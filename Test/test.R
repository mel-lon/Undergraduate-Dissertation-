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
logit_model <- glm(PSR ~ log_engagement + top_level_comment + has_flair, data = data, family = binomial)

# Predict probabilities
predicted_probabilities <- predict(logit_model, type = "response")

# Output the predicted probabilities
head(predicted_probabilities)
