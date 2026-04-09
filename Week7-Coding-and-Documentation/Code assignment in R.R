# Import data from the O*NET database, at ISCO-08 occupation level.
# The original data uses a version of SOC classification, but the data we load here
# are already cross-walked to ISCO-08 using: https://ibs.org.pl/en/resources/occupation-classifications-crosswalks-from-onet-soc-to-isco/

# The O*NET database contains information for occupations in the USA, including
# the tasks and activities typically associated with a specific occupation.
DATA_DIR <- file.path("..", "Data")
TASK_FILE <- file.path(DATA_DIR, "onet_tasks.csv")
EMPLOYMENT_FILE <- file.path(DATA_DIR, "Eurostat_employment_isco.xlsx")

if (!file.exists(TASK_FILE)) {
  stop("Missing file: ", TASK_FILE)
}

if (!file.exists(EMPLOYMENT_FILE)) {
  stop("Missing file: ", EMPLOYMENT_FILE)
}

task_data <- read.csv(TASK_FILE, stringsAsFactors = FALSE)

# isco08 variable is for occupation codes
# the t_* variables are specific tasks conducted on the job

# read employment data from Eurostat
# These datasets include quarterly information on the number of workers in specific
# 1-digit ISCO occupation categories. (Check here for details: https://www.ilo.org/public/english/bureau/stat/isco/isco08/)
COUNTRIES <- c("Belgium", "Spain", "Poland")
ISCO_SHEETS <- paste0("ISCO", 1:9)
                
# The current analysis focuses on three countries, but the code should be easy to extend to additional countries.
COUNTRIES <- c("Belgium", "Spain", "Poland")
ISCO_SHEETS <- paste0("ISCO", 1:9)

available_sheets <- readxl::excel_sheets(EMPLOYMENT_FILE)
missing_sheets <- setdiff(ISCO_SHEETS, available_sheets)

if (length(missing_sheets) > 0) {
  stop(
    "Missing sheets in employment workbook: ",
    paste(missing_sheets, collapse = ", ")
  )
}

isco_list <- lapply(seq_along(ISCO_SHEETS), function(i) {
  df <- readxl::read_excel(EMPLOYMENT_FILE, sheet = ISCO_SHEETS[i])
  
  required_cols <- c("TIME", COUNTRIES)
  missing_cols <- setdiff(required_cols, names(df))
  
  if (length(missing_cols) > 0) {
    stop(
      "Sheet ", ISCO_SHEETS[i], " is missing columns: ",
      paste(missing_cols, collapse = ", ")
    )
  }
  
  df$ISCO <- i
  df
})

# Stack all ISCO sheets into one employment dataset.
all_data <- dplyr::bind_rows(isco_list)

# Compute country-specific employment totals and occupation shares within each period.
for (country in COUNTRIES) {
  total_col <- paste0("total_", country)
  share_col <- paste0("share_", country)
  
  all_data[[total_col]] <- ave(
    all_data[[country]],
    all_data$TIME,
    FUN = function(x) sum(x, na.rm = TRUE)
  )
  
  if (any(all_data[[total_col]] <= 0, na.rm = TRUE)) {
    stop("Non-positive total employment detected for ", country)
  }
  
  all_data[[share_col]] <- all_data[[country]] / all_data[[total_col]]
  
  if (any(!is.finite(all_data[[share_col]]))) {
    stop("Non-finite occupation shares detected for ", country)
  }
}

# Prepare task data at the 1-digit ISCO level used in the employment data.
# We track non-routine cognitive analytical tasks using an Autor-style framework.
# TASK_VARS correspond to:
# 4.A.2.a.4 Analyzing Data or Information
# 4.A.2.b.2 Thinking Creatively
# 4.A.4.a.1 Interpreting the Meaning of Information for Others
TASK_VARS <- c("t_4A2a4", "t_4A2b2", "t_4A4a1")

required_task_cols <- c("isco08", TASK_VARS)
missing_task_cols <- setdiff(required_task_cols, names(task_data))

if (length(missing_task_cols) > 0) {
  stop(
    "task_data is missing required columns: ",
    paste(missing_task_cols, collapse = ", ")
  )
}

task_data$isco08_1dig <- as.integer(stringr::str_sub(task_data$isco08, 1, 1))

if (any(is.na(task_data$isco08_1dig))) {
  warning("Some task rows do not have a valid 1-digit ISCO code and will be dropped.")
}

task_data_1dig <- task_data[!is.na(task_data$isco08_1dig), c("isco08_1dig", TASK_VARS)]

aggdata <- aggregate(
  task_data_1dig[TASK_VARS],
  by = list(isco08_1dig = task_data_1dig$isco08_1dig),
  FUN = mean,
  na.rm = TRUE
)


# Combine employment shares with 1-digit task measures.
combined <- dplyr::left_join(all_data, aggdata, by = c("ISCO" = "isco08_1dig"))

missing_task_rows <- !stats::complete.cases(combined[, TASK_VARS])

if (any(missing_task_rows)) {
  missing_isco <- sort(unique(combined$ISCO[missing_task_rows]))
  stop(
    "Task merge left missing values for ISCO groups: ",
    paste(missing_isco, collapse = ", ")
  )
}

# Standardise each task variable within country using occupation shares as weights.
weighted_zscore <- function(values, weights, label) {
  if (length(values) != length(weights)) {
    stop("Length mismatch in weighted standardisation for ", label)
  }
  
  valid_rows <- complete.cases(values, weights)
  
  if (!any(valid_rows)) {
    stop("No complete cases available for ", label)
  }
  
  values_clean <- values[valid_rows]
  weights_clean <- weights[valid_rows]
  
  if (any(weights_clean < 0)) {
    stop("Negative weights found in ", label)
  }
  
  if (sum(weights_clean) <= 0) {
    stop("Weights must sum to a positive value in ", label)
  }
  
  weighted_mean <- Hmisc::wtd.mean(values_clean, weights_clean)
  weighted_var <- Hmisc::wtd.var(values_clean, weights_clean)
  
  if (is.na(weighted_var) || weighted_var <= 0) {
    stop("Weighted variance is zero or NA in ", label)
  }
  
  result <- rep(NA_real_, length(values))
  result[valid_rows] <- (values_clean - weighted_mean) / sqrt(weighted_var)
  result
}

for (task_var in TASK_VARS) {
  for (country in COUNTRIES) {
    share_col <- paste0("share_", country)
    std_col <- paste0("std_", country, "_", task_var)
    
    combined[[std_col]] <- weighted_zscore(
      values = combined[[task_var]],
      weights = combined[[share_col]],
      label = paste(task_var, country)
    )
  }
}



# Combine employment shares with 1-digit task measures.
combined <- dplyr::left_join(all_data, aggdata, by = c("ISCO" = "isco08_1dig"))

missing_task_rows <- !stats::complete.cases(combined[, TASK_VARS])

if (any(missing_task_rows)) {
  missing_isco <- sort(unique(combined$ISCO[missing_task_rows]))
  stop(
    "Task merge left missing values for ISCO groups: ",
    paste(missing_isco, collapse = ", ")
  )
}

# Standardise each task variable within country using occupation shares as weights.
weighted_zscore <- function(values, weights, label) {
  if (length(values) != length(weights)) {
    stop("Length mismatch in weighted standardisation for ", label)
  }
  
  valid_rows <- complete.cases(values, weights)
  
  if (!any(valid_rows)) {
    stop("No complete cases available for ", label)
  }
  
  values_clean <- values[valid_rows]
  weights_clean <- weights[valid_rows]
  
  if (any(weights_clean < 0)) {
    stop("Negative weights found in ", label)
  }
  
  if (sum(weights_clean) <= 0) {
    stop("Weights must sum to a positive value in ", label)
  }
  
  weighted_mean <- Hmisc::wtd.mean(values_clean, weights_clean)
  weighted_var <- Hmisc::wtd.var(values_clean, weights_clean)
  
  if (is.na(weighted_var) || weighted_var <= 0) {
    stop("Weighted variance is zero or NA in ", label)
  }
  
  result <- rep(NA_real_, length(values))
  result[valid_rows] <- (values_clean - weighted_mean) / sqrt(weighted_var)
  result
}

for (task_var in TASK_VARS) {
  for (country in COUNTRIES) {
    share_col <- paste0("share_", country)
    std_col <- paste0("std_", country, "_", task_var)
    
    combined[[std_col]] <- weighted_zscore(
      values = combined[[task_var]],
      weights = combined[[share_col]],
      label = paste(task_var, country)
    )
  }
}


# Construct occupation-level NRCA index from the three task variables.
# If your instructor specified another rule (e.g. sum instead of mean),
# change rowMeans() accordingly.
INDEX_NAME <- "NRCA"

combined[[INDEX_NAME]] <- rowMeans(combined[, TASK_VARS], na.rm = TRUE)

if (any(!is.finite(combined[[INDEX_NAME]]))) {
  stop("Non-finite NRCA values detected.")
}

# Standardise the NRCA index within each country using occupation shares as weights.
for (country in COUNTRIES) {
  share_col <- paste0("share_", country)
  std_index_col <- paste0("std_", country, "_", INDEX_NAME)
  
  combined[[std_index_col]] <- weighted_zscore(
    values = combined[[INDEX_NAME]],
    weights = combined[[share_col]],
    label = paste(INDEX_NAME, country)
  )
}

# Collapse occupation-level values into country-level NRCA time series.
required_share_cols <- paste0("share_", COUNTRIES)
required_std_index_cols <- paste0("std_", COUNTRIES, "_", INDEX_NAME)

missing_share_cols <- setdiff(required_share_cols, names(combined))
missing_std_index_cols <- setdiff(required_std_index_cols, names(combined))

if (length(missing_share_cols) > 0) {
  stop(
    "Missing share columns in combined: ",
    paste(missing_share_cols, collapse = ", ")
  )
}

if (length(missing_std_index_cols) > 0) {
  stop(
    "Missing standardised index columns in combined: ",
    paste(missing_std_index_cols, collapse = ", ")
  )
}

for (country in COUNTRIES) {
  std_index_col <- paste0("std_", country, "_", INDEX_NAME)
  share_col <- paste0("share_", country)
  contrib_col <- paste0("contrib_", country, "_", INDEX_NAME)
  
  combined[[contrib_col]] <- combined[[std_index_col]] * combined[[share_col]]
  
  if (any(!is.finite(combined[[contrib_col]]))) {
    stop("Non-finite contribution values detected for ", country)
  }
}

country_series_list <- lapply(COUNTRIES, function(country) {
  contrib_col <- paste0("contrib_", country, "_", INDEX_NAME)
  
  agg <- aggregate(
    combined[[contrib_col]],
    by = list(TIME = combined$TIME),
    FUN = sum,
    na.rm = TRUE
  )
  
  names(agg)[2] <- "value"
  agg$country <- country
  agg
})

country_series <- dplyr::bind_rows(country_series_list)

# Save plots instead of only displaying them interactively.
OUTPUT_DIR <- "Output"

if (!dir.exists(OUTPUT_DIR)) {
  dir.create(OUTPUT_DIR, recursive = TRUE)
}

for (country in COUNTRIES) {
  plot_data <- country_series[country_series$country == country, ]
  
  if (nrow(plot_data) == 0) {
    stop("No time-series data available for ", country)
  }
  
  output_file <- file.path(OUTPUT_DIR, paste0(country, "_", INDEX_NAME, ".png"))
  
  png(filename = output_file, width = 1200, height = 700, res = 120)
  
  plot(plot_data$value, xaxt = "n",
       main = paste(country, INDEX_NAME, "over time"),
       xlab = "Time",
       ylab = paste("Standardised", INDEX_NAME),
       type = "l",
       lwd = 2)
  
  tick_positions <- seq(1, nrow(plot_data), by = 3)
  
  axis(
    1,
    at = tick_positions,
    labels = plot_data$TIME[tick_positions],
    las = 2,
    cex.axis = 0.8
  )
  
  box()
  dev.off()
}

# This structure can be extended to other task bundles by changing TASK_VARS and INDEX_NAME.
# Example routine manual task items:
# 4.A.3.a.3 Controlling Machines and Processes
# 4.C.2.d.1.i Spend Time Making Repetitive Motions
# 4.C.3.d.3 Pace Determined by Speed of Equipment