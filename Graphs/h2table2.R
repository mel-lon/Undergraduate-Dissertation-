# Load the required packages
library(dplyr)
library(tidyr)
library(stats)
library(knitr)
library(kableExtra)

# Load the dataset
file_path <- "/Users/admin/Documents/University/diss-data-collection/Classifier/Sample/processed_utterances_with_date.csv"
data <- read.csv(file_path)

# Calculate log_engagement from score and num_comments
data$log_engagement <- log(data$score + data$num_comments + 1)

# Construct the linear regression model without intercept
lm_model <- lm(PSR ~ gender + top_level_comment + has_flair + is_stickied - 1, data = data)

# Get the coefficient estimates, standard errors, and t-values
coefficients <- summary(lm_model)$coefficients

# Extract coefficient estimates, standard errors, and t-values
coef <- coefficients[, 1]
se <- coefficients[, 2]
t_values <- coefficients[, 3]  # Extract t-values

# Combine results into a data frame
results <- data.frame(
  Predictor = gsub("_", " ", rownames(coefficients)), # Remove underscores and capitalize column names
  Coefficient = coef,
  SE = se,
  T_Value = t_values,  # Include t-values
  CI_Lower = coef - 1.96 * se,
  CI_Upper = coef + 1.96 * se
)

# Rename PSR to "Parasocial Language Use"
results$Predictor[results$Predictor == "PSR"] <- "Parasocial Language Use"

# Capitalize the first letter of each predictor
results$Predictor <- gsub("\\b([a-z])", "\\U\\1", results$Predictor, perl = TRUE)

# Print the results as an image table
kable(results, "html") %>%
  kable_styling(full_width = FALSE)




# Load the required package
library(lme4)

# Construct the mixed effects model
mixed_model <- lmer(log_engagement ~ gender + top_level_comment + has_flair + is_stickied + (1 | PSR), data = data)

# Get the summary of the model
summary(mixed_model)

