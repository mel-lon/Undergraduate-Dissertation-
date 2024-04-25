# Load the required packages
library(dplyr)
library(tidyr)
library(stats)

# Load the dataset
file_path <- "/Users/admin/Downloads/coded_sample.csv"
data <- read.csv(file_path)

# Calculate log_engagement from score and num_comments
data$log_engagement <- log(data$score + data$num_comments + 1)

# Construct the logistic regression model
logit_model <- lm(PSR ~ log_engagement + top_level_comment + has_flair, data = data)

# Get the coefficient estimates
coefficients <- summary(logit_model)$coefficients

# Extract coefficient estimates and standard errors
coef <- coefficients[, 1]
se <- coefficients[, 2]

# Calculate odds ratios and confidence intervals
odds_ratios <- exp(coef)
ci_lower <- exp(coef - 1.96 * se)
ci_upper <- exp(coef + 1.96 * se)

# Combine results into a data frame
results <- data.frame(
  Predictor = rownames(coefficients),
  Coefficient = coef,
  Odds_Ratio = odds_ratios,
  CI_Lower = ci_lower,
  CI_Upper = ci_upper
)

# Print the results
print(results)|
  
  
  
  
  
