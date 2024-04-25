# Load the required packages
library(ggplot2)

# Create a data frame for plotting
plot_data <- data.frame(
  Predictor = gsub("_", " ", rownames(coefficients)), # Remove underscores
  Coefficient = coef,
  CI_Lower = coef - 1.96 * se,
  CI_Upper = coef + 1.96 * se,
  Significant = ifelse((coef - 1.96 * se) * (coef + 1.96 * se) > 0 & gsub("_", " ", rownames(coefficients)) != "(Intercept)", "*", "")
)

# Capitalize the first letter of each predictor
plot_data$Predictor <- gsub("\\b([a-z])", "\\U\\1", plot_data$Predictor, perl = TRUE)

# Change "PSR" to "Parasocial Language Use"
plot_data$Predictor[plot_data$Predictor == "PSR"] <- "Parasocial Language Use"

# Plot coefficients and confidence intervals
ggplot(plot_data[plot_data$Predictor != "(Intercept)", ], aes(y = reorder(Predictor, Coefficient), x = Coefficient, xmin = CI_Lower, xmax = CI_Upper, color = Predictor)) +
  geom_point(size = 3) +
  geom_errorbarh(height = 0.2) +
  geom_text(aes(label = Significant), hjust = -0.2, vjust = -0.5, size = 5, color = "red") +
  scale_color_manual(values = c("Parasocial Language Use" = "blue", "Other Predictors" = "black")) +
  labs(x = "Coefficient Estimate", y = "Predictor", title = "Linear Regression Coefficients") +
  theme_minimal() +
  theme(legend.position = "right") +
  guides(color = guide_legend(title = "Predictors"))
