# Removed absolute paths based on reproducible research principles (e.g. setwd)

library(readxl)
library(stringr)
library(dplyr)
library(Hmisc)

# Configuration: Extract hardcoded values to the top
countries <- c("Belgium", "Spain", "Poland")
tasks_of_interest <- c("t_4A2a4", "t_4A2b2", "t_4A4a1")

# Import task data (using relative path)
task_data <- read.csv("Data/onet_tasks.csv")

# Import employment data: Avoid repetition by using a loop (lapply)
all_data <- bind_rows(lapply(1:9, function(i) {
  df <- read_excel("Data/Eurostat_employment_isco.xlsx", sheet = paste0("ISCO", i))
  df$ISCO <- i
  df
}))

# Calculate totals per country per period
totals <- all_data %>%
  group_by(TIME) %>%
  summarise(across(all_of(countries), sum, .names = "total_{.col}"))

# Join totals back and calculate shares dynamically for all countries
all_data <- all_data %>% left_join(totals, by = "TIME")
for (country in countries) {
  all_data[[paste0("share_", country)]] <- all_data[[country]] / all_data[[paste0("total_", country)]]
}

# Task data processing
task_data$isco08_1dig <- as.numeric(str_sub(task_data$isco08, 1, 1))
aggdata <- aggregate(task_data, by=list(isco08_1dig = task_data$isco08_1dig), FUN=mean, na.rm=TRUE)
aggdata$isco08 <- NULL

# Combine all data
combined <- left_join(all_data, aggdata, by = c("ISCO" = "isco08_1dig"))

# Repeated calculations extracted into a function
wtd_std <- function(series, weights) {
  mu <- wtd.mean(series, weights)
  sd <- sqrt(wtd.var(series, weights))
  (series - mu) / sd
}

# Apply standardisation across countries and tasks in nested loops
for (task in tasks_of_interest) {
  for (country in countries) {
    col_name <- paste0("std_", country, "_", task)
    combined[[col_name]] <- wtd_std(combined[[task]], combined[[paste0("share_", country)]])
  }
}

# Calculate intensity, standardise it, and compute multipliers
for (country in countries) {
  nrca_cols <- paste0("std_", country, "_", tasks_of_interest)
  combined[[paste0(country, "_NRCA")]] <- rowSums(combined[, nrca_cols])
  
  combined[[paste0("std_", country, "_NRCA")]] <- wtd_std(
    combined[[paste0(country, "_NRCA")]],
    combined[[paste0("share_", country)]]
  )
  
  combined[[paste0("multip_", country, "_NRCA")]] <- combined[[paste0("std_", country, "_NRCA")]] * combined[[paste0("share_", country)]]
}

# Aggregate by time & save output explicitly instead of transient plotting
dir.create("figures", showWarnings = FALSE)
for (country in countries) {
  col_multip <- paste0("multip_", country, "_NRCA")
  agg_data <- aggregate(combined[[col_multip]], by=list(combined$TIME), FUN=sum, na.rm=TRUE)
  
  pdf(paste0("figures/", country, "_NRCA.pdf"))
  plot(agg_data$x, xaxt="n", main=paste(country, "NRCA"), ylab="NRCA")
  axis(1, at=seq(1, 40, 3), labels=agg_data$Group.1[seq(1, 40, 3)])
  dev.off()
}
r tasks.
# E.g.:

# Routine manual
# 4.A.3.a.3	Controlling Machines and Processes
# 4.C.2.d.1.i	Spend Time Making Repetitive Motions
# 4.C.3.d.3	Pace Determined by Speed of Equipment

r tasks.
# E.g.:

# Routine manual
# 4.A.3.a.3	Controlling Machines and Processes
# 4.C.2.d.1.i	Spend Time Making Repetitive Motions
# 4.C.3.d.3	Pace Determined by Speed of Equipment

