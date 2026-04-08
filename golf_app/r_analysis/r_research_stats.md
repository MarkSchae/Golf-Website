# Golf Performance Analysis (R Project)

## 1. Objective

The goal of this project is to explore professional golf performance data and identify which statistical factors are most associated with scoring success.

This project also serves a second purpose:
- To develop practical skills in **data research, cleaning, and analysis using R**
- To better understand **what meaningful questions should be asked of a dataset**

Due to incomplete and inconsistent data (e.g. missing rounds played), this project is treated as a **proof of concept**, focusing on:
- Data cleaning
- Feature selection
- Outlier detection
- Exploratory correlation analysis

---

## 2. Data Loading & Initial Setup

```r
library(tidyverse)
library(readr)
library(dplyr)
library(skimr)
library(janitor)

df <- read_csv("data/databgkaggle.csv", show_col_types = FALSE)
```

### Initial Inspection

```r
head(df)
str(df)
colnames(df)
dim(df)
```

---

## 3. Initial Cleaning

### Limit dataset to relevant columns

```r
last_col_name <- "Official World Golf Ranking"

df_trimmed <- df %>% 
  select(1:which(colnames(df) == last_col_name))
```

### Remove unnecessary rows

```r
df_trimmed <- df_trimmed[1:212, ]
```

### Clean column names

```r
df_trimmed <- clean_names(df_trimmed)
```

---

## 4. Missing Data Analysis

```r
missing_report <- data.frame(
  column = names(df_trimmed),
  NA_values = colSums(is.na(df_trimmed)),
  blank_cells = colSums(df_trimmed == "", na.rm = TRUE),
  NA_strings = colSums(df_trimmed == "N/A", na.rm = TRUE)
)

missing_report$has_missing <- rowSums(missing_report[,2:4]) > 0
```

### Insight

- Multiple forms of missing data exist (NA, blanks, "N/A")
- Data consistency is a key limitation and affects downstream analysis

---

## 5. Removing Irrelevant Features

### Removed categories:
- Financial metrics (earnings, money rankings)
- Round split stats (early vs late performance)
- Redundant leaderboard metrics

```r
df_trimmed <- df_trimmed[, !(names(df_trimmed) %in% cols_to_drop)]
```

### Reasoning

Feature removal was guided by:
- Relevance to performance (not earnings)
- Avoiding redundancy
- Reducing noise in correlation analysis

---

## 6. Interactive Feature Selection (Shiny)

A Shiny app was used to manually refine feature selection:

```r
drop_columns_app(df_trimmed, new_name = "df_trimmed_v2")
```

### Benefits

- Visual inspection of all variables
- Manual filtering of noisy or duplicate features
- Faster iteration compared to static scripts

---

## 7. Correlation Analysis

### Define success metric

```r
df_trimmed_v2$success <- df_trimmed_v2$sub_par_rounds
```

### Correlate numeric variables with success

```r
num_df <- df_trimmed_v2[sapply(df_trimmed_v2, is.numeric)]

cors <- sapply(num_df, function(x) 
  cor(x, df_trimmed_v2$sub_par_rounds, use = "complete.obs")
)

cors <- cors[names(cors) != "sub_par_rounds"]
cors <- sort(cors, decreasing = TRUE)
```

### Insight

- Most correlations were weak (< 0.3)
- This suggests:
  - Golf performance is **multi-factorial**
  - Data limitations reduce signal strength
  - No single stat strongly explains scoring success

---

## 8. Outlier Detection

### Identify extreme values using IQR

```r
find_outliers <- function(x) {
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  which(x < (q1 - 3*iqr) | x > (q3 + 3*iqr))
}

outlier_map <- lapply(num_cols, find_outliers)
```

### Build outlier summary

```r
outlier_summary <- do.call(rbind, lapply(names(outlier_map), function(col) {
  rows <- outlier_map[[col]]
  if(length(rows) == 0) return(NULL)
  data.frame(
    row = rows,
    column = col,
    value = num_cols[[col]][rows]
  )
}))
```

---

## 9. Outlier Impact Analysis

### Count outliers per column

```r
count_outliers <- function(x) {
  if(sd(x, na.rm = TRUE) == 0) return(0)
  z <- (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
  sum(abs(z) >= 2, na.rm = TRUE)
}

outlier_counts <- sapply(num_cols, count_outliers)
```

### Severity classification

```r
outlier_summary_new$severity <- cut(
  outlier_summary_new$outlier_percent,
  breaks = c(-1, 1, 5, 15, 100),
  labels = c("insignificant", "low", "medium", "high")
)
```

### Insight

- Outliers are present across multiple metrics
- They significantly influence correlation results
- Proper handling is required before modeling

---

## 10. Cleaning Outliers

### Replace outliers with NA

```r
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
    
    df_clean[[col]][x < lower | x > upper] <- NA
  }
  
  return(df_clean)
}

clean_data_analysis <- replace_outliers_with_na(df_analysis, "name")
```

---

## 11. Feature Engineering

### Rename columns for clarity

```r
clean_data_analysis <- clean_data_analysis %>%
  rename(
    gir_percentage_200_plus_yards = gir_percentage_200_yards,
    gir_percentage_below_125_yards = gir_percentage_125_yards,
    gir_percentage_below_100_yards = gir_percentage_100_yards_2,
    gir_percentage_below_75_yards = gir_percentage_75_yards
  )
```

### Purpose

- Improve readability
- Align naming with real-world golf terminology
- Make analysis easier to interpret

---

## 12. Ranking System

### Create rankings for each metric

```r
add_rankings <- function(df, name_col = "name", lower_better_cols = NULL) {
  
  df_ranked <- df
  
  numeric_cols <- df %>%
    select(-all_of(name_col)) %>%
    select(where(is.numeric)) %>%
    colnames()
  
  for (col in numeric_cols) {
    if (col %in% lower_better_cols) {
      df_ranked[[paste0(col, "_rank")]] <- rank(df[[col]], na.last = "keep")
    } else {
      df_ranked[[paste0(col, "_rank")]] <- rank(-df[[col]], na.last = "keep")
    }
  }
  
  return(df_ranked)
}
```

---

## 13. Key Challenges

- Missing "rounds played" variable → limits normalization
- Redundant and overlapping metrics
- Outliers skewing statistical relationships
- Mixed metric types (counts, percentages, rankings)

---

## 14. Key Learnings

- Correlation alone is insufficient for performance modeling
- Data quality has a larger impact than model complexity
- Outlier handling is critical in real-world datasets
- Feature selection requires both technical and domain understanding
- Good analysis starts with asking the right questions, not just running models

---

## 15. Next Steps

- Normalize stats per round
- Reduce feature duplication 
- Develop regression or machine learning models
- Compare professional benchmarks to amateur performance
- Refine the definition of "success" beyond a single metric

---

## 16. Project Summary

This project demonstrates:
- End-to-end data handling (raw → cleaned → analyzed)
- Practical use of R for exploratory data analysis
- Critical thinking about data limitations
- The ability to move beyond code and interpret results meaningfully

While the dataset limits definitive conclusions, the process provides a strong foundation for future, more robust analysis.

# Creating a prototype prediction model

## Exploratory Data Analysis (EDA)

- Install and load EDA libraries:
  - `DataExplorer`
  - `visdat`
  - `GGally`

- Generate automated EDA report:
  - Select only numeric columns
  - Use `create_report()` to generate a full report

- Inspect dataset:
  - `glimpse()` to view structure and data types
  - `summary()` for statistical overview

- Visualize missing data:
  - `vis_dat()` to identify missing values

- Explore relationships:
  - `ggpairs()` for pairwise relationships between numeric variables

---

## Correlation Analysis

- Create correlation matrix:
  - Use numeric columns only
  - `cor(..., use = "complete.obs")`

- Highlight strong correlations:
  - Apply threshold (e.g. `|correlation| ≥ 0.5`)
  - Mark strong values with `"*"`

- Visualize:
  - `heatmaply()` with clustering

---

## Data Merging and Cleaning

- Merge datasets:
  - Join on `"name"`

- Remove unnecessary columns:
  - Drop redundant putting-related metrics

- Validate dataset:
  - Use `summary()` to confirm structure

---

## Distribution Analysis

- Analyze distributions:
  - Convert to long format (`pivot_longer`)
  - Plot boxplots (`ggplot2`)

- Example:
  - Distribution of `carry_distance`

---

## Feature Relationships

- Compute correlation with target:
  - Use `summarise(across())`
  - Compare features vs `putting_from_3`

---

## Distance vs GIR%

### Quartile Analysis
- Split `carry_distance` into quartiles (`ntile`)
- Compare GIR% using boxplots

### Scatter Plot
- Plot:
  - `carry_distance` vs `greens_in_regulation_percentage`
- Add regression line (`geom_smooth(method = "lm")`)

---

## Linear Modeling

### Simple Models
- GIR% ~ `carry_distance`
- GIR% ~ `driving_accuracy_percentage`

### Combined Model
- GIR% ~ `carry_distance + driving_accuracy_percentage`

---

## Nonlinear Modeling

### Polynomial Model
- Fit:
  - `carry_distance + carry_distance²`

- Predict:
  - Example: GIR% at distance = 240

---

## ROI Functions

### Basic ROI
- ROI = predicted(new) − predicted(current)

- Used to measure:
  - Impact of improvement (e.g. +10 yards)

---

## Distance Group Segmentation

- Create buckets:
  - `short`, `mid`, `long`, `elite`

- Model:
  - Include `distance_group`

- Dynamic ROI:
  - Adjust group when distance changes

---

## Driving Accuracy Modeling

- Polynomial model:
  - `accuracy + accuracy²`

- ROI:
  - Measure GIR% improvement from accuracy gains

---

## Iron Play Modeling

- Focus variable:
  - `gir_percentage_150_175_yards`

- Build polynomial model

- ROI:
  - Measure GIR% improvement from iron accuracy

---

## Multi-Model System

- Store models:
  - Distance model
  - Accuracy model
  - Iron model

---

## Advanced Modeling (GAM)

### GIR Model
- Use `mgcv::gam()`:
  - `s(carry_distance)`
  - `s(driving_accuracy_percentage)`
  - `s(gir_percentage_150_175_yards)`
  - Interaction: `s(carry_distance, driving_accuracy_percentage)`

---

## Dependency Models

- Accuracy model:
  - `driving_accuracy_percentage ~ s(carry_distance)`

- Iron model:
  - `gir_percentage_150_175_yards ~ s(driving_accuracy_percentage)`

---

## Simulation Workflow

### Baseline State
- Define player stats:
  - Distance
  - Accuracy
  - Iron performance

- Predict:
  - Baseline GIR%

---

### Scenario Simulation

1. Increase carry distance (+10)
2. Predict new accuracy
3. Predict new iron performance
4. Predict new GIR%

---

### ROI Calculation
- ROI = new GIR − baseline GIR

- Captures:
  - Cascading improvements
  - Interdependencies between skills

---

## Model Evaluation

- Metrics:
  - MSE (Mean Squared Error)
  - RMSE

- Compare:
  - Model vs baseline (mean prediction)

---

## Final Outcome

- Built a multi-layer predictive system that:
  - Models nonlinear relationships
  - Captures dependencies between variables
  - Simulates realistic improvement scenarios
  - Calculates ROI for performance gains

---

## Next Step

- Convert into a function or API:
  - Input: player stats
  - Output:
    - ROI per improvement type
    - Optimal improvement strategy