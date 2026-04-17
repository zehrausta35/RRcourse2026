library(readxl)   # read Excel sheets
library(dplyr)    # data manipulation
library(stringr)  # string helpers
library(Hmisc)    # weighted mean / var

# --- Configurable inputs ---------------------------------------------------
# Change these at the top to adapt the script
data_folder <- "Data"
onet_tasks_file <- file.path(data_folder, "onet_tasks.csv")
eurostat_file <- file.path(data_folder, "Eurostat_employment_isco.xlsx")

# Sheets for ISCO 1-digit groups (1..9)
isco_sheet_names <- paste0("ISCO", 1:9)

# Countries we will analyse (add or remove names here)
countries <- c("Belgium", "Spain", "Poland")

# Task variables used to build the NRCA index
task_variables <- c("t_4A2a4", "t_4A2b2", "t_4A4a1")

# --- Helper functions ------------------------------------------------------
# Read a single ISCO sheet and attach the ISCO 1-digit id
read_isco_sheet <- function(sheet_name, id) {
  df <- read_excel(eurostat_file, sheet = sheet_name)
  df$ISCO <- id
  df
}

# Weighted standardisation: (x - weighted_mean) / weighted_sd
weighted_standardize <- function(values, weights) {
  # If weights are all NA or sum to zero, return NA vector
  if (all(is.na(weights)) || sum(weights, na.rm = TRUE) == 0) {
    return(rep(NA_real_, length(values)))
  }
  m <- wtd.mean(values, weights, na.rm = TRUE)
  s <- sqrt(wtd.var(values, weights, na.rm = TRUE))
  if (is.na(s) || s == 0) {
    return(rep(NA_real_, length(values)))
  }
  (values - m) / s
}

# Repeat a data.frame n times by row-binding (useful to align totals with stacked ISCO rows)
repeat_df_rows <- function(df, times) {
  do.call(rbind, replicate(times, df, simplify = FALSE))
}

# --- Load data --------------------------------------------------------------
# Task-level data from O*NET
task_data <- read.csv(onet_tasks_file, stringsAsFactors = FALSE)

# Read all ISCO sheets into a list, then combine
isco_list <- lapply(seq_along(isco_sheet_names), function(i) {
  read_isco_sheet(isco_sheet_names[i], i)
})
all_isco <- bind_rows(isco_list)

# --- Compute country totals across ISCO groups ------------------------------
# Each ISCO sheet has the same time index. Sum the country columns across sheets
# Step 1: extract country columns from each sheet and sum them row-wise
country_totals_per_time <- Reduce(function(acc, df) {
  acc + df[countries]
}, lapply(isco_list, function(df) df[countries]))

# Step 2: repeat the totals for each ISCO group so they align with the stacked all_isco rows
totals_repeated <- repeat_df_rows(country_totals_per_time, length(isco_list))
colnames(totals_repeated) <- paste0("total_", colnames(totals_repeated))

# Attach totals to the stacked ISCO data
all_isco <- bind_cols(all_isco, totals_repeated)

# --- Compute occupation shares per country ----------------------------------
# share_country = workers_in_occupation / total_workers_in_country_at_time
for (cty in countries) {
  total_col <- paste0("total_", cty)
  share_col <- paste0("share_", cty)
  all_isco[[share_col]] <- all_isco[[cty]] / all_isco[[total_col]]
}

# --- Aggregate task data to 1-digit ISCO -----------------------------------
# Create 1-digit ISCO variable and compute mean of task variables by that digit
task_data$isco08_1dig <- as.numeric(str_sub(task_data$isco08, 1, 1))

agg_tasks <- task_data %>%
  group_by(isco08_1dig) %>%
  summarise(across(all_of(task_variables), ~ mean(.x, na.rm = TRUE))) %>%
  ungroup()

# --- Merge tasks with employment data ---------------------------------------
combined <- left_join(all_isco, agg_tasks, by = c("ISCO" = "isco08_1dig"))

# --- Standardise each task variable by country using occupation shares -------
# This will create columns like std_Belgium_t_4A2a4, etc.
for (task_var in task_variables) {
  for (cty in countries) {
    weight_col <- paste0("share_", cty)
    out_col <- paste0("std_", cty, "_", task_var)
    combined[[out_col]] <- weighted_standardize(combined[[task_var]], combined[[weight_col]])
  }
}

# --- Build NRCA index per country (sum of the three standardized tasks) -----
for (cty in countries) {
  std_cols <- paste0("std_", cty, "_", task_variables)
  nr_col <- paste0(cty, "_NRCA")
  # rowSums with na.rm = TRUE so missing task values don't break the sum
  combined[[nr_col]] <- rowSums(combined[std_cols], na.rm = TRUE)
}

# --- Standardise NRCA per country -------------------------------------------
for (cty in countries) {
  nr_col <- paste0(cty, "_NRCA")
  std_nr_col <- paste0("std_", cty, "_NRCA")
  weight_col <- paste0("share_", cty)
  combined[[std_nr_col]] <- weighted_standardize(combined[[nr_col]], combined[[weight_col]])
}

# --- Compute weighted country-level NRCA time series ------------------------
# Multiply standardized NRCA by occupation share, then sum across ISCO groups by TIME
for (cty in countries) {
  std_nr_col <- paste0("std_", cty, "_NRCA")
  multip_col <- paste0("multip_", cty, "_NRCA")
  combined[[multip_col]] <- combined[[std_nr_col]] * combined[[paste0("share_", cty)]]
}

# Aggregate by TIME to get a single time series per country
nr_time_series <- lapply(countries, function(cty) {
  multip_col <- paste0("multip_", cty, "_NRCA")
  combined %>%
    group_by(TIME) %>%
    summarise(nr_mean = sum(.data[[multip_col]], na.rm = TRUE)) %>%
    arrange(TIME)
})
names(nr_time_series) <- countries

# --- Simple plotting with readable axes -------------------------------------
# One plot per country, with TIME labels chosen automatically
par(mfrow = c(length(countries), 1), mar = c(4, 4, 2, 1))
for (cty in countries) {
  df <- nr_time_series[[cty]]
  plot(df$nr_mean, type = "l", xaxt = "n",
       main = paste(cty, "NRCA (weighted mean)"),
       xlab = "TIME", ylab = "NRCA")
  # Use pretty tick positions and label them with TIME values
  ticks <- pretty(seq_len(nrow(df)))
  ticks <- ticks[ticks >= 1 & ticks <= nrow(df)]
  axis(1, at = ticks, labels = df$TIME[ticks])
}
par(mfrow = c(1, 1)