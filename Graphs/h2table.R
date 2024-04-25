# Load the required packages
library(dplyr)
library(broom)
library(knitr)
library(kableExtra)

# Read the dataset
file_path <- "/Users/admin/Documents/University/diss-data-collection/Classifier/Sample/processed_utterances_with_date.csv"
data <- read.csv(file_path)

# Calculate log engagement
data$log_engagement <- log(data$score + data$num_comments + 1)

# Filter data for male and female subreddits
male_data <- data %>% filter(gender == 1)
female_data <- data %>% filter(gender == 0)

# Fit linear regression models for male and female subreddits
male_model <- lm(log_engagement ~ PSR, data = male_data)
female_model <- lm(log_engagement ~ PSR, data = female_data)

# Extract coefficients and p-values
male_summary <- tidy(male_model)
female_summary <- tidy(female_model)

# Filter coefficients for parasocial language
male_psr <- male_summary %>% filter(term == "PSR")
female_psr <- female_summary %>% filter(term == "PSR")

# Create a comparison table without P-value
comparison_table <- data.frame(
  Subreddit = c("Male", "Female"),
  Coefficient = c(male_psr$estimate, female_psr$estimate)
)

# Print the comparison table as an image
comparison_table_image <- kable(comparison_table, "html") %>%
  kable_styling(full_width = FALSE)

comparison_table_image
