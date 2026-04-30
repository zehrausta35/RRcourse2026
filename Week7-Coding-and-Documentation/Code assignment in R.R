# ============================================================
# O*NET / Eurostat – Non-Routine Cognitive Analytical (NRCA)
# task-content index for selected European countries
# ============================================================
#
# Data sources
#   - O*NET task data cross-walked to ISCO-08:
#     https://ibs.org.pl/en/resources/occupation-classifications-crosswalks-from-onet-soc-to-isco/
#   - Eurostat quarterly employment by 1-digit ISCO occupation
#     (https://www.ilo.org/public/english/bureau/stat/isco/isco08/)
#
# Framework: Autor / Acemoglu non-routine cognitive analytical tasks
#   4.A.2.a.4  Analyzing Data or Information
#   4.A.2.b.2  Thinking Creatively
#   4.A.4.a.1  Interpreting the Meaning of Information for Others
# ============================================================

library(readxl)
library(stringr)
library(dplyr)
library(Hmisc)

# ------------------------------------------------------------------
# Parameters  (change these to extend the analysis)
# ------------------------------------------------------------------
data_dir   <- "Data"
n_isco     <- 9                                  # 1-digit ISCO categories (1–9)
countries  <- c("Belgium", "Spain", "Poland")
task_vars  <- c("t_4A2a4", "t_4A2b2", "t_4A4a1")
tick_step  <- 3                                  # axis label spacing in plots

# ------------------------------------------------------------------
# Load data
# ------------------------------------------------------------------
task_data <- read.csv(file.path(data_dir, "onet_tasks.csv"))
# isco08 = occupation code; t_* = task intensity scores

excel_file <- file.path(data_dir, "Eurostat_employment_isco.xlsx")

# Read all 9 ISCO sheets in one loop and attach the category number
isco_list <- lapply(seq_len(n_isco), function(i) {
  df      <- read_excel(excel_file, sheet = paste0("ISCO", i))
  df$ISCO <- i
  df
})

# ------------------------------------------------------------------
# Country-level employment totals (sum over all ISCO categories)
# ------------------------------------------------------------------
calc_country_total <- function(isco_list, country) {
  Reduce(`+`, lapply(isco_list, `[[`, country))
}

totals <- setNames(
  lapply(countries, calc_country_total, isco_list = isco_list),
  countries
)

# ------------------------------------------------------------------
# Merge ISCO sheets and add totals + shares
# ------------------------------------------------------------------
all_data <- do.call(rbind, isco_list)

for (ctry in countries) {
  all_data[[paste0("total_", ctry)]] <- rep(totals[[ctry]], n_isco)
  all_data[[paste0("share_", ctry)]] <- all_data[[ctry]] /
                                        all_data[[paste0("total_", ctry)]]
}

# ------------------------------------------------------------------
# Aggregate task data to 1-digit ISCO level
# ------------------------------------------------------------------
task_data$isco08_1dig <- as.numeric(str_sub(task_data$isco08, 1, 1))

aggdata          <- aggregate(task_data, by = list(task_data$isco08_1dig),
                              FUN = mean, na.rm = TRUE)
aggdata$isco08   <- NULL

combined <- left_join(all_data, aggdata, by = c("ISCO" = "isco08_1dig"))

# ------------------------------------------------------------------
# Helper: weighted standardisation  (mean → 0, sd → 1)
# ------------------------------------------------------------------
wtd_standardise <- function(x, weights) {
  m  <- wtd.mean(x, weights)
  sd <- sqrt(wtd.var(x, weights))
  (x - m) / sd
}

# ------------------------------------------------------------------
# Standardise each task variable for each country
# ------------------------------------------------------------------
for (ctry in countries) {
  for (task in task_vars) {
    combined[[paste0("std_", ctry, "_", task)]] <-
      wtd_standardise(combined[[task]],
                      combined[[paste0("share_", ctry)]])
  }
}

# ------------------------------------------------------------------
# NRCA index = sum of the three standardised task scores
# ------------------------------------------------------------------
for (ctry in countries) {
  std_cols <- paste0("std_", ctry, "_", task_vars)
  combined[[paste0(ctry, "_NRCA")]] <- rowSums(combined[, std_cols])
}

# Standardise NRCA itself
for (ctry in countries) {
  combined[[paste0("std_", ctry, "_NRCA")]] <-
    wtd_standardise(combined[[paste0(ctry, "_NRCA")]],
                    combined[[paste0("share_", ctry)]])
}

# ------------------------------------------------------------------
# Weighted country-level NRCA aggregated over time
# ------------------------------------------------------------------
agg_list <- setNames(vector("list", length(countries)), countries)

for (ctry in countries) {
  combined[[paste0("multip_", ctry, "_NRCA")]] <-
    combined[[paste0("std_", ctry, "_NRCA")]] *
    combined[[paste0("share_", ctry)]]

  agg_list[[ctry]] <- aggregate(
    combined[[paste0("multip_", ctry, "_NRCA")]],
    by  = list(combined$TIME),
    FUN = sum, na.rm = TRUE
  )
}

# ------------------------------------------------------------------
# Plot NRCA trends for each country
# ------------------------------------------------------------------
n_periods <- nrow(agg_list[[countries[1]]])

for (ctry in countries) {
  agg      <- agg_list[[ctry]]
  tick_pos <- seq(1, n_periods, tick_step)

  plot(agg$x, xaxt = "n",
       main = paste(ctry, "– NRCA over time"),
       xlab = "Time", ylab = "NRCA index")
  axis(1, at = tick_pos, labels = agg$Group.1[tick_pos])
}

# ------------------------------------------------------------------
# To add more countries: append to the `countries` vector above.
# To add more task categories (e.g. Routine Manual):
#   4.A.3.a.3   Controlling Machines and Processes
#   4.C.2.d.1.i Spend Time Making Repetitive Motions
#   4.C.3.d.3   Pace Determined by Speed of Equipment
# append those variable names to `task_vars`.
# ------------------------------------------------------------------
