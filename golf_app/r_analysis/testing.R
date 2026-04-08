library(tidyverse)

df <- read_csv("data/driving2025.csv")

head(df)
list.files("data")

str(df)
df$accuracy <- as.numeric(gsub("%", "", df$`%`))
head(df$accuracy)

df$calc_accuracy <- df$`FAIRWAYS HIT` / df$`POSSIBLE FAIRWAYS` * 100
head(df[, c("accuracy", "calc_accuracy")])
summary(df$accuracy)
hist(df$accuracy)

summary(df)
hist(df$accuracy, main="Driving Accuracy Distribution", xlab="Accuracy %", col="skyblue", breaks=10)


plot(df$`POSSIBLE FAIRWAYS`, df$accuracy,
     main="Accuracy vs Fairways Attempted",
     xlab="Possible Fairways",
     ylab="Accuracy %",
     pch=19, col="darkgreen")
head(df[order(-df$accuracy), c("PLAYER", "accuracy")], 10)
head(df, 50)  # first 20 rows
print(df, n = nrow(df))

head(df[order(df$accuracy), c("PLAYER", "accuracy")], 10)
# Top 5 most accurate players with volume
df %>% arrange(desc(accuracy)) %>% select(PLAYER, accuracy, `POSSIBLE FAIRWAYS`) %>% head(5)


cor(df$accuracy, df$`POSSIBLE FAIRWAYS`)


# Get list of all CSV files in data folder
files <- list.files("data", pattern = "*.csv", full.names = TRUE)
# Read all CSVs and store in a list
dfs <- lapply(files, read_csv)
problems(df_all)
getwd()
list.files()
list.files("data")
df <- read.csv("data/birds_2025.csv")
head(df)
str(df)
colnames(df)
dim(df)
colnames(df)[6] <- "TOTAL_BIRDIES"
df_all <- bind_rows(all_data)
files <- list.files("data", full.names = TRUE)
files
all_data <- lapply(files, read.csv)
all_data <- lapply(files, function(f) {
  read.csv(f, stringsAsFactors = FALSE, fill = TRUE)
})
library(readr)

all_data <- lapply(files, function(f) {
  read_csv(f, show_col_types = FALSE)
})
# Check parsing problems in the first file
problems(all_data[[1]])
# Check a few more files for problems
problems(all_data[[2]])
problems(all_data[[3]])
# Extract column names from all files
col_names_list <- lapply(all_data, colnames)

# Check if all files have the same column names
all_same <- all(sapply(col_names_list, function(x) all(x == col_names_list[[1]])))

all_same
library(readr)
library(dplyr)

df <- read_csv("data/databgkaggle.csv", show_col_types = FALSE)
problems(df)
library(readr)

df <- read_csv(
  "data/databgkaggle.csv",
  show_col_types = FALSE,
  col_types = cols(.default = "c"),  # read everything as character to avoid type mismatch
  na = c("", "NA"),
  progress = FALSE
)
library(readr)

# Assuming you read one CSV already
df <- read_csv("data/databgkaggle.csv", show_col_types = FALSE)

# Look at rows with parsing issues
problems(df)
# Get parsing problems
parse_issues <- problems(df)

# Look at first few
head(parse_issues)
library(readr)
library(dplyr)

# Read CSV
df <- read_csv("data/databgkaggle.csv", show_col_types = FALSE)

# Inspect column names
colnames(df)

#  (adjust to actual last column)
library(dplyr)

# Assign the column name as a string
last_col_name <- "Official World Golf Ranking"

# Select columns from 1 to that column
df_trimmed <- df %>% select(1:which(colnames(df) == last_col_name))

# Check
colnames(df_trimmed)
dim(df_trimmed)



# See the first few rows
head(df_trimmed)

# Get a summary of each column
summary(df_trimmed)

# Check structure and types
str(df_trimmed)

# Number of rows and columns
dim(df_trimmed)
# Opens the data in a new tab/window like Excel
View(df_trimmed)
# Keep only rows 1 to 213
df_trimmed <- df_trimmed[1:212, ]


install.packages("skimr")
library(skimr)

skim(df_trimmed)

df_trimmed <- df_trimmed %>%
  select(-`Official World Golf Ranking`)

install.packages("janitor")

library(janitor)
df_trimmed <- clean_names(df_trimmed)

names(df_trimmed)[colSums(is.na(df_trimmed)) > 0]


missing_report <- data.frame(
  column = names(df_trimmed),
  n_missing = colSums(is.na(df_trimmed)),
  pct_missing = colMeans(is.na(df_trimmed)) * 100
)

missing_report$has_missing <- missing_report$n_missing > 0

missing_report

missing_report <- data.frame(
  column = names(df_trimmed),
  NA_values = colSums(is.na(df_trimmed)),
  blank_cells = colSums(df_trimmed == "", na.rm = TRUE),
  NA_strings = colSums(df_trimmed == "N/A", na.rm = TRUE)
)

missing_report$has_missing <- rowSums(missing_report[,2:4]) > 0
options(max.print = 5000)

missing_report


# Columns to drop
cols_to_drop <- c(
  "official_money",
  "career_money_leaders",
  "career_earnings",
  "money_per_event_leaders",
  "total_money_official_and_unofficial",
  "percentage_of_available_purse_won",
  "percentage_of_potential_money_won",
  "fedex_cup_regular_season_points",
  "fed_ex_cup_points_per_event_leaders",
  "pga_championship_points",
  "percent_of_potential_pts_won_fed_ex_cup_regular_season",
  "fed_ex_cup_standings",
  "all_around_ranking",
  "aon_risk_reward_challenge",
  "rsm_birdies_fore_love",
  "victory_leaders",
  "victory_leaders", # repeated in original list
  # early/late round specific metrics (excluding round scoring metrics you want to keep)
  "early_scoring_average",
  "early_lowest_round",
  "first_tee_early_scoring_average",
  "tenth_tee_early_scoring_average",
  "early_round_1_scoring_average",
  "early_round_2_scoring_average",
  "early_round_3_scoring_average",
  "early_round_4_scoring_average",
  "first_tee_early_round_1_scoring_average",
  "tenth_tee_early_round_1_scoring_average",
  "tenth_tee_early_round_2_scoring_average",
  "first_tee_early_round_3_scoring_average",
  "first_tee_early_round_4_scoring_average",
  "first_tee_early_lowest_round",
  "tenth_tee_early_lowest_round",
  "late_scoring_average",
  "late_lowest_round",
  "late_round_1_scoring_average",
  "late_round_2_scoring_average",
  "late_round_3_scoring_average",
  "late_round_4_scoring_average",
  "first_tee_late_scoring_average",
  "tenth_tee_late_scoring_average",
  "first_tee_late_round_1_scoring_average",
  "first_tee_late_round_2_scoring_average",
  "tenth_tee_late_round_2_scoring_average",
  "first_tee_late_round_3_scoring_average",
  "first_tee_late_round_4_scoring_average",
  "first_tee_late_lowest_round",
  "tenth_tee_late_lowest_round"
)

# Drop columns from your dataframe (assuming your df is called `df`)
df_clean <- df[, !(names(df) %in% cols_to_drop)]
skim(df_clean)

df_trimmed <- df_trimmed[, !(names(df_trimmed) %in% cols_to_drop)]
skim(df_trimmed)
names(df_trimmed)


# Turn column names into a data frame so you can View them
View(data.frame(column_name = colnames(df_trimmed)))


install.packages("DT")

library(shiny)
library(DT)
library(dplyr)

drop_columns_app <- function(df, new_name = "df_trimmed_dropped") {
  stopifnot(is.data.frame(df))
  
  ui <- fluidPage(
    titlePanel("Select columns to drop"),
    sidebarLayout(
      sidebarPanel(
        textInput("new_name", "New data frame name", value = new_name),
        selectizeInput(
          "cols_drop",
          "Columns to drop",
          choices = names(df),
          multiple = TRUE,
          options = list(placeholder = "Type to search columns...", maxOptions = 5000)
        ),
        actionButton("apply", "Apply (create new data frame)")
      ),
      mainPanel(
        DTOutput("preview")
      )
    )
  )
  
  server <- function(input, output, session) {
    df_after <- reactive({
      if (is.null(input$cols_drop) || length(input$cols_drop) == 0) return(df)
      df %>% select(-all_of(input$cols_drop))
    })
    
    output$preview <- renderDT({
      datatable(head(df_after(), 10), options = list(scrollX = TRUE, pageLength = 10))
    })
    
    observeEvent(input$apply, {
      nm <- input$new_name
      if (is.null(nm) || nm == "") nm <- new_name
      assign(nm, df_after(), envir = .GlobalEnv)
      showNotification(paste0("Created ", nm, " (", ncol(df_after()), " cols)."), type = "message")
    })
  }
  
  shinyApp(ui, server)
}

# Run (this does not modify df_trimmed)
drop_columns_app(df_trimmed, new_name = "df_trimmed_v2")
names(df_trimmed_v2)
skim(df_trimmed_v2)
view(df_trimmed_v2)



# Example target
df_trimmed_v2$success <- df_trimmed_v2$sub_par_rounds

# Keep numeric columns only
num_df <- df_trimmed_v2[sapply(df_trimmed_v2, is.numeric)]

# Correlation of each numeric feature with success
cors <- sapply(names(num_df), function(nm) cor(num_df[[nm]], df_trimmed_v2$success, use = "complete.obs"))

cors <- sort(cors[!is.na(cors)], decreasing = TRUE)

# Show top positive and negative relationships
head(cors, 5)
tail(cors, 5)


# Keep only numeric columns
num_df <- df_trimmed_v2[sapply(df_trimmed_v2, is.numeric)]

# Correlate everything with sub_par_rounds
cors <- sapply(num_df, function(x) cor(x, df_trimmed_v2$sub_par_rounds, use = "complete.obs"))

# Remove the correlation with itself
cors <- cors[names(cors) != "sub_par_rounds"]

# Sort
cors <- sort(cors, decreasing = TRUE)

# View results
head(cors, 5)
tail(cors, 15)


model <- lm(sub_par_rounds ~ birdie_average, data = df_trimmed_v2)

cooks <- cooks.distance(model)

plot(cooks, type="h")
abline(h = 4/length(cooks), col="red")
which(cooks > 4/length(cooks))
view(df_trimmed_v2[which(cooks > 4/length(cooks)), ])


num_cols <- df_trimmed_v2[, sapply(df_trimmed_v2, is.numeric)]
outlier_cols <- sapply(num_cols, function(x) {
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  
  any(x < (q1 - 3 * iqr) | x > (q3 + 3 * iqr), na.rm = TRUE)
})
names(outlier_cols[outlier_cols])


num_cols <- df_trimmed_v2[, sapply(df_trimmed_v2, is.numeric)]
for(col in names(num_cols)) {
  x <- num_cols[[col]]
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  lower <- q1 - 3 * iqr
  upper <- q3 + 3 * iqr
  
  outliers <- which(x < lower | x > upper)
  if(length(outliers) > 0) {
    print(paste("Column:", col, "Outlier rows:", paste(outliers, collapse=", ")))
  }
}





num_cols <- df_trimmed_v2[, sapply(df_trimmed_v2, is.numeric)]

# Function to detect 3xIQR outliers
find_outliers <- function(x) {
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  which(x < (q1 - 3*iqr) | x > (q3 + 3*iqr))
}

# Apply to all numeric columns
outlier_map <- lapply(num_cols, find_outliers)

# Build consistent summary table
outlier_summary <- do.call(rbind, lapply(names(outlier_map), function(col) {
  rows <- outlier_map[[col]]
  if(length(rows) == 0) return(NULL)  # skip empty
  data.frame(
    row = rows,
    column = rep(col, length(rows)),
    value = num_cols[[col]][rows],  # extract as vector with [[ ]]
    stringsAsFactors = FALSE
  )
}))

head(outlier_summary, 20)


# --- Dataset ---
# df_trimmed_v2 assumed loaded

# --- Identify numeric columns ---
num_cols <- df_trimmed_v2[, sapply(df_trimmed_v2, is.numeric)]

# --- Function: detect 3xIQR outliers and reason ---
iqr_outliers_with_reason <- function(x) {
  q1 <- quantile(x, 0.25, na.rm=TRUE)
  q3 <- quantile(x, 0.75, na.rm=TRUE)
  iqr <- q3 - q1
  lower <- q1 - 3*iqr
  upper <- q3 + 3*iqr
  
  below <- which(x < lower)
  above <- which(x > upper)
  
  if(length(below) + length(above) == 0) return(NULL)
  
  data.frame(
    row = c(below, above),
    value = c(x[below], x[above]),
    reason = c(rep(paste0("below lower bound (", round(lower,2), ")"), length(below)),
               rep(paste0("above upper bound (", round(upper,2), ")"), length(above))),
    stringsAsFactors = FALSE
  )
}

# --- Scan all numeric columns ---
outlier_map <- lapply(num_cols, iqr_outliers_with_reason)

# --- Build a tidy table of flagged cells ---
outlier_summary <- do.call(rbind, lapply(names(outlier_map), function(col) {
  df <- outlier_map[[col]]
  if(is.null(df)) return(NULL)
  df$column <- col
  df$type <- "3xIQR_outlier"
  df[, c("row", "column", "value", "type", "reason")]
}))

# --- Sort for easier inspection ---
outlier_summary <- outlier_summary[order(outlier_summary$column, outlier_summary$row), ]

# --- View all flagged cells ---
outlier_summary
view(outlier_summary)




# --- Identify numeric columns ---
num_cols <- df_trimmed_v2[, sapply(df_trimmed_v2, is.numeric)]
num_col_names <- names(num_cols)

# --- Function: detect 3xIQR outliers ---
iqr_outlier_mask <- function(x) {
  q1 <- quantile(x, 0.25, na.rm=TRUE)
  q3 <- quantile(x, 0.75, na.rm=TRUE)
  iqr <- q3 - q1
  lower <- q1 - 3*iqr
  upper <- q3 + 3*iqr
  x < lower | x > upper
}

# --- Create mask of outliers for all numeric columns ---
outlier_masks <- lapply(num_cols, iqr_outlier_mask)

# --- Initialize wide-format outlier table ---
outlier_table <- data.frame(
  row = 1:nrow(df_trimmed_v2),
  player_name = df_trimmed_v2$name,
  stringsAsFactors = FALSE
)

# --- Fill each numeric column with outlier value or NA ---
for(col in num_col_names) {
  mask <- outlier_masks[[col]]
  outlier_table[[col]] <- ifelse(mask, num_cols[[col]], NA)
}

# --- Remove rows without any outliers ---
outlier_table <- outlier_table[rowSums(!is.na(outlier_table[num_col_names])) > 0, ]

# --- View the result ---
view(outlier_table)






# --- Identify numeric columns ---
num_cols <- df_trimmed_v2[, sapply(df_trimmed_v2, is.numeric)]
num_col_names <- names(num_cols)

# --- Wide-format table with player name ---
outlier_table <- data.frame(
  row = 1:nrow(df_trimmed_v2),
  player_name = df_trimmed_v2$name,
  stringsAsFactors = FALSE
)

# --- Loop through numeric columns ---
for(col in num_col_names) {
  x <- num_cols[[col]]
  mean_x <- mean(x, na.rm=TRUE)
  sd_x <- sd(x, na.rm=TRUE)
  
  q1 <- quantile(x, 0.25, na.rm=TRUE)
  q3 <- quantile(x, 0.75, na.rm=TRUE)
  iqr <- q3 - q1
  lower <- q1 - 3*iqr
  upper <- q3 + 3*iqr
  
  # identify extreme outliers
  mask <- x < lower | x > upper
  
  # store outlier value
  outlier_table[[col]] <- ifelse(mask, x, NA)
  
  # compute extremity measures
  outlier_table[[paste0(col,"_zscore")]] <- ifelse(mask, round((x - mean_x)/sd_x, 2), NA)
  outlier_table[[paste0(col,"_iqr_extreme")]] <- ifelse(mask,
                                                        round(ifelse(x < lower, (lower - x)/iqr, (x - upper)/iqr), 2),
                                                        NA)
}

# --- Keep only rows with any outlier ---
value_cols <- num_col_names
outlier_table <- outlier_table[rowSums(!is.na(outlier_table[value_cols])) > 0, ]

# --- Result ---
view(outlier_table)






# --- Identify numeric columns ---
num_cols <- df_trimmed_v2[, sapply(df_trimmed_v2, is.numeric)]
num_col_names <- names(num_cols)

# --- Initialize wide-format outlier table with player names ---
outlier_table <- data.frame(
  row = 1:nrow(df_trimmed_v2),
  player_name = df_trimmed_v2$name,
  stringsAsFactors = FALSE
)

# --- Loop through numeric columns ---
for(col in num_col_names) {
  x <- num_cols[[col]]
  
  # basic stats
  mean_x <- mean(x, na.rm=TRUE)
  sd_x <- sd(x, na.rm=TRUE)
  q1 <- quantile(x, 0.25, na.rm=TRUE)
  q3 <- quantile(x, 0.75, na.rm=TRUE)
  iqr <- q3 - q1
  lower <- q1 - 3*iqr
  upper <- q3 + 3*iqr
  
  # identify extreme outliers
  mask <- x < lower | x > upper
  
  # store flagged value
  outlier_table[[col]] <- ifelse(mask, x, NA)
  
  # compute extremity measures
  z <- (x - mean_x)/sd_x
  outlier_table[[paste0(col,"_zscore")]] <- ifelse(mask, round(z,2), NA)
  iqr_extreme <- ifelse(x < lower, (lower - x)/iqr, (x - upper)/iqr)
  outlier_table[[paste0(col,"_iqr_extreme")]] <- ifelse(mask, round(iqr_extreme,2), NA)
  
  # --- assign outlier label ---
  label <- rep(NA, length(x))
  label[mask & abs(z) >= 5] <- "Highly suspicious"
  label[mask & abs(z) >= 3 & abs(z) < 5] <- "Extreme outlier"
  label[mask & abs(z) >= 2 & abs(z) < 3] <- "Moderate outlier"
  label[mask & abs(z) < 2] <- "Mild outlier"
  
  outlier_table[[paste0(col,"_label")]] <- label
}

# --- Keep only rows with any outlier ---
value_cols <- num_col_names
outlier_table <- outlier_table[rowSums(!is.na(outlier_table[value_cols])) > 0, ]

# --- View result ---
view(outlier_table)





# --- Identify numeric columns ---
num_cols <- df_trimmed_v2[, sapply(df_trimmed_v2, is.numeric)]

# --- Function (robust to sd = 0) ---
has_mid_high_outliers <- function(x) {
  if (sd(x, na.rm = TRUE) == 0) return(FALSE)
  z <- (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
  any(abs(z) >= 2, na.rm = TRUE)
}

# --- Apply and FORCE a named logical vector ---
outlier_check <- unlist(lapply(num_cols, has_mid_high_outliers))

# --- Extract column names ONLY ---
clean_columns <- names(outlier_check)[outlier_check == FALSE]

# --- Print clean column names ---
view(clean_columns)
str(outlier_check)
View(data.frame(column = clean_columns)) 
View(df_trimmed_v2[, c("name", clean_columns)])
clean_col_new <- df_trimmed_v2[, c("name", clean_columns)]







# --- Function to count mid/high outliers ---
count_outliers <- function(x) {
  if (sd(x, na.rm = TRUE) == 0) return(0)
  z <- (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
  sum(abs(z) >= 2, na.rm = TRUE)
}

# --- Apply to all numeric columns ---
outlier_counts <- sapply(num_cols, count_outliers)

outlier_summary <- data.frame(
  column = names(outlier_counts),
  outlier_count = as.numeric(outlier_counts),
  row.names = NULL
)

# Sort by worst columns first
outlier_summary <- outlier_summary[order(-outlier_summary$outlier_count), ]

View(outlier_summary)







library(shiny)

# Use the clean_columns vector from before (or any column names you want to choose from)
# For demo, let's use all numeric columns
num_cols <- df_trimmed_v2[, sapply(df_trimmed_v2, is.numeric)]
all_column_names <- names(num_cols)

# --- Shiny app ---
ui <- fluidPage(
  titlePanel("Select Columns for Analysis"),
  sidebarLayout(
    sidebarPanel(
      helpText("Select the columns you want to include in analysis:"),
      selectInput(
        inputId = "cols_to_keep",
        label = "Choose columns",
        choices = all_column_names,
        selected = NULL,
        multiple = TRUE,
        width = "300px"
      ),
      actionButton("save_btn", "Save Selection")
    ),
    mainPanel(
      h4("Selected Columns:"),
      verbatimTextOutput("selected_cols")
    )
  )
)

server <- function(input, output, session) {
  
  # Display currently selected columns
  output$selected_cols <- renderPrint({
    input$cols_to_keep
  })
  
  # Save selection when button is clicked
  observeEvent(input$save_btn, {
    # Save to global environment variable
    assign("analysis_clean", input$cols_to_keep, envir = .GlobalEnv)
    showNotification(paste(length(input$cols_to_keep), "columns saved to analysis_clean!"))
  })
  
}

# Run the app
shinyApp(ui = ui, server = server)

df_analysis <- df_trimmed_v2[, analysis_clean]
view(df_analysis)
# add name
analysis_clean <- c("name", analysis_clean)

# subset the data
df_analysis <- df_trimmed_v2[, analysis_clean]
# Summary of numeric columns
summary(df_analysis)









# Numeric columns (exclude name)
num_cols_new <- df_analysis[, sapply(df_analysis, is.numeric)]

# Reuse the z-score outlier function
count_outliers <- function(x) {
  if(sd(x, na.rm = TRUE) == 0) return(0)
  z <- (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
  sum(abs(z) >= 2, na.rm = TRUE)
}

# Apply to new numeric columns
outlier_counts_new <- sapply(num_cols_new, count_outliers)

# Make a summary table
outlier_summary_new <- data.frame(
  column = names(outlier_counts_new),
  outlier_count = as.numeric(outlier_counts_new),
  row.names = NULL
)

# Sort by worst columns
outlier_summary_new <- outlier_summary_new[order(-outlier_summary_new$outlier_count), ]

# Optional: add percent of rows flagged
outlier_summary_new$outlier_percent <- 
  outlier_summary_new$outlier_count / nrow(num_cols_new) * 100

View(outlier_summary_new)
# Define thresholds based on % of rows flagged
outlier_summary_new$severity <- cut(
  outlier_summary_new$outlier_percent,
  breaks = c(-1, 1, 5, 15, 100),  # percentage ranges
  labels = c("insignificant", "low", "medium", "high")
)

# View updated table
View(outlier_summary_new)
df_analysis <- df_analysis[, !names(df_analysis) %in% c("putts_made_distance", "average_distance_of_putts_made")]










# Numeric columns
num_cols_new <- df_analysis[, sapply(df_analysis, is.numeric)]

# Function to get the max absolute z-score in a column
max_z <- function(x) {
  if(sd(x, na.rm = TRUE) == 0) return(0)  # constant column → no effect
  z <- (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
  max(abs(z), na.rm = TRUE)
}

# Apply to all numeric columns
outlier_magnitude <- sapply(num_cols_new, max_z)



outlier_summary_new$severity_magnitude <- cut(
  outlier_magnitude,
  breaks = c(-1, 2, 5, 10, Inf),  # SD thresholds
  labels = c("insignificant", "low", "medium", "high")
)


# Reuse percent of rows flagged previously
outlier_summary_new$outlier_score <- outlier_summary_new$outlier_percent * outlier_magnitude
View(outlier_summary_new)
















get_outlier_table <- function(df, name_col = "name") {
  
  # Pivot to long format
  df_long <- df %>%
    pivot_longer(
      cols = -all_of(name_col),
      names_to = "column",
      values_to = "value"
    )
  
  # Compute IQR bounds per column
  bounds <- df_long %>%
    group_by(column) %>%
    summarise(
      q1 = quantile(value, 0.25, na.rm = TRUE),
      q3 = quantile(value, 0.75, na.rm = TRUE),
      iqr = q3 - q1,
      lower = q1 - 1.5 * iqr,
      upper = q3 + 1.5 * iqr,
      .groups = "drop"
    )
  
  # Join bounds back and filter outliers
  outliers <- df_long %>%
    left_join(bounds, by = "column") %>%
    filter(value < lower | value > upper) %>%
    mutate(
      severity = case_when(
        value > upper ~ (value - upper) / (iqr + 1e-9),
        value < lower ~ (lower - value) / (iqr + 1e-9)
      )
    ) %>%
    select(
      !!name_col,
      column,
      value,
      severity
    ) %>%
    arrange(desc(severity))
  
  return(outliers)
}

outlier_table <- get_outlier_table(df_analysis, name_col = "name")
options(scipen = 999)
View(outlier_table)










replace_outliers_with_na <- function(df, name_col = "name") {
  
  df_clean <- df
  
  numeric_cols <- df %>%
    select(-all_of(name_col)) %>%
    select(where(is.numeric)) %>%
    colnames()
  
  for (col in numeric_cols) {
    
    x <- df[[col]]
    
    q1 <- quantile(x, 0.25, na.rm = TRUE)
    q3 <- quantile(x, 0.75, na.rm = TRUE)
    iqr <- q3 - q1
    
    lower <- q1 - 1.5 * iqr
    upper <- q3 + 1.5 * iqr
    
    # Replace outliers with NA
    df_clean[[col]][x < lower | x > upper] <- NA
  }
  
  return(df_clean)
}
clean_data_analysis <- replace_outliers_with_na(df_analysis, "name")
colSums(is.na(clean_data_analysis)) %>%
  sort(decreasing = TRUE)
view(clean_data_analysis)


clean_data_analysis <- clean_data_analysis %>%
  rename(gir_percentage_200_plus_yards = gir_percentage_200_yards,
         gir_percentage_below_125_yards = gir_percentage_125_yards,
         gir_percentage_below_100_yards = gir_percentage_100_yards_2,
         gir_percentage_below_75_yards = gir_percentage_75_yards)

clean_data_analysis <- clean_data_analysis %>%
  select(-total_1_putts_25)





add_rankings <- function(df, name_col = "name", lower_better_cols = NULL) {
  
  df_ranked <- df
  
  numeric_cols <- df %>%
    select(-all_of(name_col)) %>%
    select(where(is.numeric)) %>%
    colnames()
  
  for (col in numeric_cols) {
    
    if (col %in% lower_better_cols) {
      # Lower = better
      df_ranked[[paste0(col, "_rank")]] <- rank(df[[col]], na.last = "keep", ties.method = "average")
    } else {
      # Higher = better (default)
      df_ranked[[paste0(col, "_rank")]] <- rank(-df[[col]], na.last = "keep", ties.method = "average")
    }
  }
  
  return(df_ranked)
}
lower_better_cols <- c("spin_rate")
ranked_data <- add_rankings(clean_data_analysis, "name", lower_better_cols)
view(ranked_data)


# Get all column names
cols <- colnames(ranked_data)

# Identify the name column (keep first)
name_col <- "name"

# All other columns except name
other_cols <- setdiff(cols, name_col)

# Separate original vs rank columns
orig_cols <- other_cols[!grepl("_rank$", other_cols)]
rank_cols <- other_cols[grepl("_rank$", other_cols)]

# Build new column order: interleave original + rank
new_order <- c(name_col)

for (col in orig_cols) {
  rank_col <- paste0(col, "_rank")
  if (rank_col %in% rank_cols) {
    new_order <- c(new_order, col, rank_col)
  } else {
    new_order <- c(new_order, col)
  }
}

# Reorder the data.frame
ranked_data <- ranked_data[, new_order]

# Check result
View(ranked_data)


round_cols <- paste0("round_", 1:4, "_scoring_average")

ranked_data <- ranked_data %>%
  mutate(across(all_of(round_cols), ~ ifelse(. < 60 | . > 85, NA, .)))




# Replace "John" with the player you want
player_name <- "Jon Rahm"

player_row <- ranked_data[ranked_data$name == player_name, ]

View(player_row)


clean_data_analysis <- clean_data_analysis %>%
  select(-total_3_putts_15_20, -total_3_putts_20_25, -round_1_scoring_average, -round_2_scoring_average, -round_3_scoring_average, -round_4_scoring_average, -sub_par_rounds, -consecutive_fairways_hit, -consecutive_gir, -best_ytd_streak_w_o_a_3_putt, -best_sub_par_rounds_streak, -ytd_rounds_in_60s_streak, -ytd_sub_par_rounds_streak, -current_streak_without_a_3_putt)

install.packages("DataExplorer")

library(DataExplorer)
eda_df <- clean_data_analysis %>%
  select(where(is.numeric))
create_report(eda_df)

dplyr::glimpse(clean_data_analysis)
summary(clean_data_analysis)
install.packages("visdat")
library(visdat)
vis_dat(clean_data_analysis)

install.packages("GGally")
library(GGally)

clean_data_analysis_new %>%
  select(where(is.numeric)) %>%
  ggpairs()

install.packages("heatmaply")
library(heatmaply)

heat_map_analysis <- clean_data_analysis_new %>% select(where(is.numeric))
cor_matrix <- cor(heat_map_analysis, use = "complete.obs")  
threshold <- 0.5
cell_symbols <- ifelse(abs(cor_matrix) >= threshold, "*", "")
suppressWarnings(
  heatmaply(cor_matrix, 
            k_col = 3, 
            k_row = 3,
            xlab = "Variables",
            ylab = "Variables",
            main = "Correlation Heatmap",
            cellnote = cell_symbols,
            fontsize_row = 12,
            fontsize_col = 12)
)


merged_df <- merge(clean_data_analysis, clean_col_new, by = "name")
view(merged_df)
clean_data_analysis_new <- merged_df[, !(names(merged_df) %in% c("bogey_average", "putts_made_per_event_over_10", "overall_putting_average", "putting_average"))]
view(clean_data_analysis_new)

summary(clean_data_analysis_new)



clean_data_analysis_new %>%
  select(carry_distance) %>%
  pivot_longer(cols = everything(), names_to = "metric", values_to = "value") %>%
  ggplot(aes(x = metric, y = value)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Distribution of Key Golf Metrics") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))




clean_data_analysis_new %>%
  select(carry_distance, driving_accuracy_percentage, ball_speed, spin_rate, putting_from_3) %>%
  summarise(across(
    -putting_from_3,
    ~ cor(.x, putting_from_3, use = "complete.obs")
  ))


df_dst <- clean_data_analysis_new %>%
  mutate(distance_quartile = ntile(carry_distance, 4))

ggplot(df_dst, aes(x = factor(distance_quartile), y = greens_in_regulation_percentage)) +
  geom_boxplot() +
  labs(
    title = "GIR% by Driving Distance Quartile",
    x = "Driving Distance Quartile (1 = shortest, 4 = longest)",
    y = "GIR %"
  ) +
  theme_minimal()



ggplot(clean_data_analysis_new, aes(x = carry_distance, y = greens_in_regulation_percentage)) +
  geom_point() +
  theme_minimal() +
  labs(
    title = "Carry Distance vs GIR %",
    x = "Carry Distance",
    y = "GIR %"
  )

ggplot(clean_data_analysis_new, aes(x = carry_distance, y = greens_in_regulation_percentage)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE) +
  theme_minimal()


model_dst <- lm(greens_in_regulation_percentage ~ carry_distance, data = clean_data_analysis_new)
summary(model_dst)

model_dr_acc <- lm(greens_in_regulation_percentage ~ driving_accuracy_percentage, data = clean_data_analysis_new)
summary(model_dr_acc)

model_dr_acc_dst <- lm(greens_in_regulation_percentage ~ driving_accuracy_percentage + carry_distance, data = clean_data_analysis_new)
summary(model_dr_acc_dst)








ggplot(clean_data_analysis_new, aes(x = driving_accuracy_percentage, y = greens_in_regulation_percentage)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE) +
  theme_minimal()


df_dr_acc <- clean_data_analysis_new %>%
  mutate(distance_quartile = ntile(driving_accuracy_percentage, 4))

ggplot(df_dr_acc, aes(x = factor(distance_quartile), y = greens_in_regulation_percentage)) +
  geom_boxplot() +
  labs(
    title = "GIR% by Driving Acc Quartile",
    x = "Driving Acc Quartile (1 = shortest, 4 = longest)",
    y = "GIR %"
  ) +
  theme_minimal()





clean_data_analysis_new$distance_group <- cut(clean_data_analysis_new$carry_distance,
                         breaks=c(0,260,280,300,380),
                         labels=c("short","mid","long","elite"))

lm(greens_in_regulation_percentage ~ carry_distance * distance_group, data=clean_data_analysis_new)

model_dst_predict <- lm(greens_in_regulation_percentage ~ carry_distance + I(carry_distance^2), data=clean_data_analysis_new)
predict(model_dst_predict, newdata = data.frame(carry_distance = 240))


gird_roi <- function(current, new, model) {
  pred1 <- predict(model, data.frame(carry_distance = current))
  pred2 <- predict(model, data.frame(carry_distance = new))
  return(pred2 - pred1)
}
gird_roi(300, 310, model_dst_predict)


lm(greens_in_regulation_percentage ~ carry_distance + I(carry_distance^2) +
     distance_group +
     carry_distance:distance_group +
     I(carry_distance^2):distance_group,
   data = clean_data_analysis_new)





model_dst_predict_new <- lm(greens_in_regulation_percentage ~ carry_distance + I(carry_distance^2) + distance_group, data=clean_data_analysis_new)


get_group_dst <- function(distance) {
  if (distance < 260) {
    return("short")
  } else if (distance < 280) {
    return("mid")
  } else if (distance < 300) {
    return("long")
  } else {
    return("elite")
  }
}

gird_roi_dst_incr <- function(current, new, model) {
  
  group1 <- get_group_dst(current)
  group2 <- get_group_dst(new)
  
  pred1 <- predict(model, data.frame(
    carry_distance = current,
    distance_group = group1
  ))
  
  pred2 <- predict(model, data.frame(
    carry_distance = new,
    distance_group = group2
  ))
  
  return(pred2 - pred1)
}

gird_roi_dst_incr(270, 280, model_dst_predict_new)
predict(model_dst_predict_new, newdata = data.frame(carry_distance = 240, distance_group = get_group_dst(240)))








model_drive_acc <- lm(greens_in_regulation_percentage ~ driving_accuracy_percentage + I(driving_accuracy_percentage^2), data = clean_data_analysis_new)
gird_roi_dr_acc <- function(current, new, model) {
  pred1 <- predict(model, data.frame(driving_accuracy_percentage = current))
  pred2 <- predict(model, data.frame(driving_accuracy_percentage = new))
  return(pred2 - pred1)
}
gird_roi_dr_acc(20, 50, model_drive_acc)
predict(model_drive_acc, newdata = data.frame(driving_accuracy_percentage = 0))



cols_data_gir <- c(
  "gir_percentage_200_plus_yards",
  "gir_percentage_175_200_yards",
  "gir_percentage_150_175_yards",
  "gir_percentage_125_150_yards",
  "gir_percentage_100_125_yards",
  "gir_percentage_below_125_yards",
  "gir_percentage_below_100_yards",
  "gir_percentage_below_75_yards",
  "gir_percentage_75_100_yards"
)

cor_matrix_gir_data <- cor(clean_data_analysis_new[, c("greens_in_regulation_percentage", cols_data_gir)],
    use = "complete.obs")

cor_matrix_gir_data["greens_in_regulation_percentage", cols_data_gir]

ggplot(clean_data_analysis_new, aes(x = gir_percentage_below_75_yards, y = greens_in_regulation_percentage)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE) +
  theme_minimal()


gir_means <- colMeans(
  clean_data_analysis_new[, cols_data_gir],
  na.rm = TRUE
)
sort(gir_means)




model_iron_acc <- lm(greens_in_regulation_percentage ~ gir_percentage_150_175_yards + I(gir_percentage_150_175_yards^2), data = clean_data_analysis_new)
gird_roi_iron_acc <- function(current, new, model) {
  pred1 <- predict(model, data.frame(gir_percentage_150_175_yards = current))
  pred2 <- predict(model, data.frame(gir_percentage_150_175_yards = new))
  return(pred2 - pred1)
}
gird_roi_iron_acc(50, 70, model_iron_acc)









models_list_gir_roi <- list(
  dst = model_dst_predict_new,
  acc = model_drive_acc,
  iron = model_iron_acc
)




library(mgcv)

model_gir_gam <- gam(
  greens_in_regulation_percentage ~
    s(carry_distance) +
    s(driving_accuracy_percentage) +
    s(gir_percentage_150_175_yards) +
    s(carry_distance, driving_accuracy_percentage),
  
  data = clean_data_analysis_new,
  method = "REML"
)
accuracy_model_gam <- gam(
  driving_accuracy_percentage ~ s(carry_distance),
  data = clean_data_analysis_new
)

iron_model_gam <- gam(
  gir_percentage_150_175_yards ~ s(driving_accuracy_percentage),
  data = clean_data_analysis_new
)
summary(model_gir_gam)
state_golfer_test = list( gir_percentage_150_175_yards = 60, carry_distance = 270, driving_accuracy_percentage = 55)

baseline <- predict(model_gir_gam, newdata = state_golfer_test)

baseline

baseline_state <- state_golfer_test

baseline_accuracy <- predict(accuracy_model_gam, baseline_state)
baseline_iron <- predict(iron_model_gam, baseline_state)
baseline_gir <- predict(model_gir_gam, baseline_state)

new_state <- state_golfer_test
new_state$carry_distance <- new_state$carry_distance + 10

new_accuracy <- predict(accuracy_model_gam, new_state)
new_iron <- predict(iron_model_gam, new_state)
new_gir <- predict(model_gir_gam, new_state)


impact <- list(
  accuracy_change = new_accuracy - baseline_accuracy,
  iron_change = new_iron - baseline_iron,
  gir_change = new_gir - baseline_gir
)

impact










new_state <- state_golfer_test

# Step 1: change carry distance
new_state$carry_distance <- new_state$carry_distance + 10

# Step 2: propagate effect
new_state$driving_accuracy_percentage <- predict(
  accuracy_model_gam,
  newdata = new_state
)

# Step 3: propagate again
new_state$gir_percentage_150_175_yards <- predict(
  iron_model_gam,
  newdata = new_state
)

# Step 4: final GIR
new_pred <- predict(model_gir_gam, new_state)

roi <- new_pred - baseline
roi





evaluate_model <- function(model, data, response_var) {
  
  pred <- predict(model, newdata = data)
  actual <- data[[response_var]]
  
  mse <- mean((actual - pred)^2, na.rm = TRUE)
  
  baseline <- mean(actual, na.rm = TRUE)
  baseline_mse <- mean((actual - baseline)^2, na.rm = TRUE)
  
  list(
    mse = mse,
    rmse = sqrt(mse),
    baseline_mse = baseline_mse,
    improvement = baseline_mse - mse
  )
}

evaluate_model(model_gir_gam, clean_data_analysis_new, "greens_in_regulation_percentage")
evaluate_model(accuracy_model_gam, clean_data_analysis_new, "driving_accuracy_percentage")
evaluate_model(iron_model_gam, clean_data_analysis_new, "gir_percentage_150_175_yards")
