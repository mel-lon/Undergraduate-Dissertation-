# Load the required packages
library(dplyr)
library(tidyr)
library(stats)
library(knitr)
library(kableExtra)

# Load the dataset
file_path <- "/Users/admin/Downloads/coded_sample.csv"
data <- read.csv(file_path)

# Calculate log_engagement from score and num_comments
data$log_engagement <- log(data$score + data$num_comments + 1)

# Construct the linear regression model
lm_model <- lm(log_engagement ~ PSR + top_level_comment + has_flair + is_stickied, data = data)

# Get the coefficient estimates, standard errors, and t-values
coefficients <- summary(lm_model)$coefficients

# Extract coefficient estimates, standard errors, and t-values
coef <- coefficients[, 1]
se <- coefficients[, 2]
t_values <- coefficients[, 3]  # Extract t-values

# Extract predictor names and remove underscores
predictor_names <- gsub("_", " ", rownames(coefficients))

# Combine results into a data frame
results <- data.frame(
  Predictor = predictor_names, # Use modified predictor names
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
