# Install and load required packages
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
if (!requireNamespace("forcats", quietly = TRUE)) {
  install.packages("forcats")
}
library(ggplot2)
library(forcats)

# Create a data frame for plotting
plot_data <- data.frame(
  Predictor = results$Predictor,
  Coefficient = results$Coefficient,
  CI_Lower = results$CI_Lower,
  CI_Upper = results$CI_Upper,
  Significant = ifelse((results$Coefficient - 1.96 * results$SE) * (results$Coefficient + 1.96 * results$SE) > 0 & results$Predictor != "(Intercept)", "*", "")
)

# Inverse the order of predictors
plot_data$Predictor <- fct_rev(plot_data$Predictor)

# Plot coefficients and confidence intervals
ggplot(plot_data[plot_data$Predictor != "(Intercept)", ], aes(y = Predictor, x = Coefficient, xmin = CI_Lower, xmax = CI_Upper, color = Predictor)) +
  geom_point(size = 3) +
  geom_errorbarh(height = 0.2) +
  geom_text(aes(label = Significant), hjust = -0.2, vjust = -0.5, size = 5, color = "red") +
  scale_color_manual(values = c("ender" = "green", "other" = "black"))+
  labs(x = "Coefficient Estimate", y = "Predictor", title = "Linear Regression Coefficients") +
  theme_minimal() +
  theme(legend.position = "right") +
  
