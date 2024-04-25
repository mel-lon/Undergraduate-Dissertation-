# Load the required packages
library(dplyr)
library(tidyr)
library(stats)
library(knitr)
library(kableExtra)
library(lme4)
library(ggplot2)

# Load the dataset
file_path <- "/Users/admin/Documents/University/diss-data-collection/Classifier/Sample/processed_utterances_with_date.csv"
data <- read.csv(file_path)

# Calculate log_engagement from score and num_comments
data$log_engagement <- log(data$score + data$num_comments + 1)

# Construct the mixed effects model
mixed_model <- lmer(log_engagement ~ gender + top_level_comment + has_flair + is_stickied + (1 | subreddit) + (1 | random_speaker), data = data)

# Get the summary of the model
summary(mixed_model)

# Plot the coefficients
coef_data <- data.frame(coef(summary(mixed_model)))
coef_data$Predictor <- rownames(coef_data)
coef_data <- coef_data[-1, ]  # Remove the intercept

# Extract coefficients from the mixed effects model
mixed_effects_coefs <- coef(summary(mixed_model))

# Create a data frame for plotting
plot_data <- data.frame(
  Predictor = rownames(mixed_effects_coefs),
  Coefficient = mixed_effects_coefs[, 1],
  SE = mixed_effects_coefs[, 2],
  CI_Lower = mixed_effects_coefs[, 1] - 1.96 * mixed_effects_coefs[, 2],
  CI_Upper = mixed_effects_coefs[, 1] + 1.96 * mixed_effects_coefs[, 2],
  Significant = ifelse(abs(mixed_effects_coefs[, 1] / mixed_effects_coefs[, 2]) > 1.96, "*", "")
)

# Define colors for predictors

# Capitalize the predictors and remove underscores
plot_data$Predictor <- gsub("_", " ", plot_data$Predictor)
plot_data$Predictor <- gsub("^\\s*(\\S)", "\\U\\1", plot_data$Predictor, perl = TRUE)

# Change the label of the (Intercept) predictor to Parasocial Language Use
plot_data$Predictor[plot_data$Predictor == "(Intercept)"] <- "(Intercept) Parasocial Language Use"

# Plot coefficients and confidence intervals
ggplot(plot_data, aes(y = Predictor, x = Coefficient, xmin = CI_Lower, xmax = CI_Upper, color = Predictor)) +
  geom_point(size = 3) +
  geom_errorbarh(height = 0.2) +
  geom_text(aes(label = Significant), hjust = -0.2, vjust = -0.5, size = 5, color = "red") +
  scale_color_manual(values = c("Gender" = "green", "other" = "black")) +
  labs(x = "Coefficient Estimate", y = "Predictor", title = "Mixed Effects Model Coefficients") +
  theme_minimal() +
  theme(legend.position = "none")
