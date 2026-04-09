
# Libraries
#install.packages("dplyr")
#install.packages("readxl")
#install.packages("stringr")
#install.packages("Hmisc")
library(dplyr)
library(readxl)
library(stringr)
library(Hmisc)

# Set the path to the parent directory of RR classes
setwd("/Users/anutek/Desktop/Studies/SEM4/ReproducibleResearch/repositories/RRCourse2026")

# Import data from the O*NET database, at ISCO-08 occupation level
# https://ibs.org.pl/en/resources/occupation-classifications-crosswalks-from-onet-soc-to-isco/

# The O*NET database contains information for occupations in the USA, including
# the tasks and activities typically associated with a specific occupation.
onet = read.csv("Data/onet_tasks.csv")

# Import employment data from Eurostat
# These datasets include quarterly information on the number of workers in specific
# 1-digit ISCO occupation categories. (Check here for details: https://www.ilo.org/public/english/bureau/stat/isco/isco08/)
eurostat <- "Data/Eurostat_employment_isco.xlsx"

for (i in 1:9) {
  assign(paste0("isco", i), read_excel(eurostat, sheet = paste0("ISCO", i)))
}

# Calculate worker totals in each of the chosen countries.
countries <- c("Belgium", "Spain", "Poland")
isco_list <- list(isco1, isco2, isco3, isco4, isco5, isco6, isco7, isco8, isco9)

for (country in countries) {
  assign(
    paste0("total_", country),
    Reduce("+", lapply(isco_list, `[[`, country))
  )
}

# Merge all datasets
eurostat <- bind_rows(isco_list, .id = "ISCO")

# Add total employment and occupation shares for each country
for (country in countries) {
  eurostat[[paste0("total_", country)]] <- rep(get(paste0("total_", country)), 9)
  eurostat[[paste0("share_", country)]] <- eurostat[[country]] / eurostat[[paste0("total_", country)]]
}

# Extract first digit of the ISCO variable and aggregate task data by occupation
onet$isco08_1dig <- str_sub(onet$isco08, 1, 1) %>%
  as.numeric()
aggdata <- aggregate(onet, by = list(onet$isco08_1dig), FUN = mean, na.rm = TRUE)
aggdata$isco08 <- NULL

# Merge employment and task data
combined <- left_join(eurostat %>% mutate(ISCO = as.numeric(ISCO)), aggdata, by = c("ISCO" = "isco08_1dig"))

# Non-routine cognitive analytical (NRCA) task items (Autor & Acemoglu framework)
tasks <- c("t_4A2a4", "t_4A2b2", "t_4A4a1")

# Standardise each task item using country employment shares as weights
for (country in countries) {
  for (task in tasks) {
    temp_mean <- wtd.mean(combined[[task]], combined[[paste0("share_", country)]])
    temp_sd <- wtd.var(combined[[task]], combined[[paste0("share_", country)]]) %>% sqrt()
    combined[[paste0("std_", country, "_", task)]] <- (combined[[task]] - temp_mean) / temp_sd
  }
}

# Calculate NRCA as sum of standardised task items, then re-standardise
for (country in countries) {
  combined[[paste0(country, "_NRCA")]] <- Reduce("+", lapply(tasks, function(task) {
    combined[[paste0("std_", country, "_", task)]]
  }))
  temp_mean <- wtd.mean(combined[[paste0(country, "_NRCA")]], combined[[paste0("share_", country)]])
  temp_sd <- wtd.var(combined[[paste0(country, "_NRCA")]], combined[[paste0("share_", country)]]) %>% sqrt()
  combined[[paste0("std_", country, "_NRCA")]] <- (combined[[paste0(country, "_NRCA")]] - temp_mean) / temp_sd
}

# Compute weighted NRCA and aggregate over time
agg_list <- list()
for (country in countries) {
  combined[[paste0("multip_", country, "_NRCA")]] <- combined[[paste0("std_", country, "_NRCA")]] * combined[[paste0("share_", country)]]
  agg_list[[country]] <- aggregate(combined[[paste0("multip_", country, "_NRCA")]], by = list(combined$TIME), FUN = sum, na.rm = TRUE)
}

# Plot NRCA trends for each country
for (country in countries) {
  plot(agg_list[[country]]$x, xaxt = "n", main = country,
       xlab = "Year", ylab = "NRCA Index")
  axis(1, at = seq(1, 40, 3), labels = agg_list[[country]]$Group.1[seq(1, 40, 3)])
}

