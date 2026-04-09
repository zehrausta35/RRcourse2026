# Sets the path to the parent directory of RR classes
setwd("C:\\Users\\Marta\\repositories\\RRcourse2026")

library(here)
library(readxl)
library(dplyr)
library(stringr)
library(Hmisc)

# Parameters
COUNTRIES <- c("Belgium", "Spain", "Poland")
TASK_VARS <- c("t_4A2a4", "t_4A2b2", "t_4A4a1")

# Load data
task_data <- read.csv(here("Data", "onet_tasks.csv"))

isco_list <- lapply(1:9, function(i) {
  df <- read_excel(here("Data", "Eurostat_employment_isco.xlsx"),
                   sheet = paste0("ISCO", i))
  df$ISCO <- i
  df
})

all_data <- bind_rows(isco_list)

# Compute total employment per country
for (country in COUNTRIES) {
  total <- Reduce(`+`, lapply(isco_list, function(df) df[[country]]))
  all_data[[paste0("total_", country)]] <- rep(total, times = length(isco_list))
}

# Compute employment shares
for (country in COUNTRIES) {
  all_data[[paste0("share_", country)]] <-
    all_data[[country]] / all_data[[paste0("total_", country)]]
}

# Prepare task data (ISCO 1-digit level)
task_data$isco08_1dig <- as.numeric(str_sub(task_data$isco08, 1, 1))

aggdata <- task_data |>
  group_by(isco08_1dig) |>
  summarise(across(everything(), ~mean(.x, na.rm = TRUE))) |>
  select(-isco08)

# Merge employment and task data
combined <- left_join(all_data, aggdata,
                      by = c("ISCO" = "isco08_1dig"))

# Weighted standardisation function
wtd_std <- function(series, weights) {
  mu <- wtd.mean(series, weights)
  sd <- sqrt(wtd.var(series, weights))
  (series - mu) / sd
}

# Standardise selected task variables
for (task in TASK_VARS) {
  for (country in COUNTRIES) {
    combined[[paste0("std_", country, "_", task)]] <-
      wtd_std(
        combined[[task]],
        combined[[paste0("share_", country)]]
      )
  }
}

# Compute NRCA index (sum of standardised tasks)
for (country in COUNTRIES) {
  std_cols <- paste0("std_", country, "_", TASK_VARS)
  combined[[paste0(country, "_NRCA")]] <-
    rowSums(combined[, std_cols], na.rm = TRUE)
}

# Standardise NRCA index
for (country in COUNTRIES) {
  combined[[paste0("std_", country, "_NRCA")]] <-
    wtd_std(
      combined[[paste0(country, "_NRCA")]],
      combined[[paste0("share_", country)]]
    )
}

# Aggregate to country-time level
results <- list()

for (country in COUNTRIES) {
  combined[[paste0("multip_", country)]] <-
    combined[[paste0("std_", country, "_NRCA")]] *
    combined[[paste0("share_", country)]]
  
  results[[country]] <-
    aggregate(combined[[paste0("multip_", country)]],
              by = list(combined$TIME),
              FUN = sum, na.rm = TRUE)
}

# Plot results
for (country in COUNTRIES) {
  df <- results[[country]]
  
  plot(df$x, main = paste(country, "NRCA"),
       xaxt = "n", type = "l")
  
  axis(1,
       at = seq(1, nrow(df), 3),
       labels = df$Group.1[seq(1, nrow(df), 3)])
}
