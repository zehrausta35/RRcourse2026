# Sets the path to the parent directory of RR classes
setwd("/Users/matsoikwan/Library/Mobile Documents/com~apple~CloudDocs/University of Warsaw/Reproducible Research/RRcourse2026")

# Load required libraries
library(readxl)
library(stringr)
library(dplyr)
library(Hmisc)

# Countries to analyse
countries <- c("Belgium", "Spain", "Poland")

# Task variables of interest
# 4.A.2.a.4  Analyzing Data or Information
# 4.A.2.b.2  Thinking Creatively
# 4.A.4.a.1  Interpreting the Meaning of Information for Others
task_vars <- c("t_4A2a4", "t_4A2b2", "t_4A4a1")

# Extract the CSV file
task_data <- read.csv("Data/onet_tasks.csv")

# Keep only the first digit of ISCO code
task_data$isco08_1dig <- str_sub(task_data$isco08, 1, 1) %>% as.numeric()

# Aggregate task values to 1-digit ISCO level
aggdata <- aggregate(task_data, by = list(task_data$isco08_1dig), FUN = mean, na.rm = TRUE)
aggdata$isco08 <- NULL

# Use a loop instead of reading each sheet separately
isco_list <- list()
for (i in 1:9) {
  isco_list[[i]]       <- read_excel("Data/Eurostat_employment_isco.xlsx", sheet = paste0("ISCO", i))
  isco_list[[i]]$ISCO  <- i
}

# Stack all sheets into one data frame
all_data <- do.call(rbind, isco_list)

# Calculate totals and shares for each country
for (country in countries) {
  
  # Sum employment across all 9 ISCO sheets for this country
  country_total <- Reduce("+", lapply(isco_list, function(df) df[[country]]))
  
  # Repeat 9 times to match the stacked data frame
  all_data[[paste0("total_", country)]] <- rep(country_total, times = 9)
  
  # Share = this occupation / total
  all_data[[paste0("share_", country)]] <- all_data[[country]] / all_data[[paste0("total_", country)]]
}

# Merge employment data with task data
combined <- left_join(all_data, aggdata, by = c("ISCO" = "isco08_1dig"))

# Standardise task variables using a function 
wtd_standardise <- function(x, weights) {
  w_mean <- wtd.mean(x, weights)
  w_sd   <- sqrt(wtd.var(x, weights))
  return((x - w_mean) / w_sd)
}

# Apply it for every country and every task variable
for (country in countries) {
  for (task in task_vars) {
    combined[[paste0("std_", country, "_", task)]] <- wtd_standardise(
      combined[[task]],
      combined[[paste0("share_", country)]]
    )
  }
}

# Calculate NRCA index and standardise it
for (country in countries) {
  
  # NRCA = sum of the three standardised task scores
  combined[[paste0(country, "_NRCA")]] <-
    combined[[paste0("std_", country, "_t_4A2a4")]] +
    combined[[paste0("std_", country, "_t_4A2b2")]] +
    combined[[paste0("std_", country, "_t_4A4a1")]]
  
  # Standardise NRCA as well
  combined[[paste0("std_", country, "_NRCA")]] <- wtd_standardise(
    combined[[paste0(country, "_NRCA")]],
    combined[[paste0("share_", country)]]
  )
  
  # Multiply by share (for weighted aggregation)
  combined[[paste0("multip_", country, "_NRCA")]] <-
    combined[[paste0("std_", country, "_NRCA")]] * combined[[paste0("share_", country)]]
}

# Aggregate to country-time level
agg_Belgium <- aggregate(combined$multip_Belgium_NRCA, by = list(combined$TIME), FUN = sum, na.rm = TRUE)
agg_Spain   <- aggregate(combined$multip_Spain_NRCA,   by = list(combined$TIME), FUN = sum, na.rm = TRUE)
agg_Poland  <- aggregate(combined$multip_Poland_NRCA,  by = list(combined$TIME), FUN = sum, na.rm = TRUE)

# Plot results one by one
plot(agg_Poland$x, xaxt = "n", main = "Poland NRCA", xlab = "Time", ylab = "NRCA")
axis(1, at = seq(1, nrow(agg_Poland), 3), labels = agg_Poland$Group.1[seq(1, nrow(agg_Poland), 3)])

plot(agg_Spain$x, xaxt = "n", main = "Spain NRCA", xlab = "Time", ylab = "NRCA")
axis(1, at = seq(1, nrow(agg_Spain), 3), labels = agg_Spain$Group.1[seq(1, nrow(agg_Spain), 3)])

plot(agg_Belgium$x, xaxt = "n", main = "Belgium NRCA", xlab = "Time", ylab = "NRCA")
axis(1, at = seq(1, nrow(agg_Belgium), 3), labels = agg_Belgium$Group.1[seq(1, nrow(agg_Belgium), 3)])