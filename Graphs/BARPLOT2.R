# Load the required packages
library(ggplot2)
library(dplyr)

# Load the dataset
file_path <- "/Users/admin/Downloads/coded_sample.csv"
data <- read.csv(file_path)

# Calculate log_engagement from score and num_comments
data$log_engagement <- log(data$score + data$num_comments + 1)

# Construct the linear regression model
lm_model <- lm(PSR ~ gender + top_level_comment + has_flair + is_stickied, data = data)

# Get the coefficient estimates, standard errors, and t-values
coefficients <- summary(lm_model)$coefficients

# Extract t-values
t_values <- coefficients[, 3]  # Extract t-values

# Capitalize the first letter of predictor names and remove underscores
predictor_names <- gsub("_", " ", rownames(coefficients))  # Remove underscores
predictor_names <- sapply(predictor_names, function(x) paste0(toupper(substr(x, 1, 1)), substr(x, 2, nchar(x))))  # Capitalize first letters

# Prepare data for plotting
plot_data <- data.frame(
  Predictor = predictor_names,
  T_Value = t_values
)

# Remove intercept (first row)
plot_data <- plot_data[-1, ]

# Plot comparison table as a fancy bar plot
ggplot(plot_data, aes(x = Predictor, y = T_Value, fill = Predictor)) +
  geom_bar(stat = "identity", width = 0.5, color = "black") +
  geom_text(aes(label = round(T_Value, 2)), vjust = 1.5, size = 3, color = "black") +  # Add t-values above bars
  labs(title = "Comparison of t-values for Predictors of Parasocial Language Use",
       x = "Predictor",
       y = "t-value") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 10, face = "bold"),
        axis.title.y = element_text(size = 10, face = "bold"),
        plot.title = element_text(size = 12, face = "bold", hjust = 0.5),
        axis.text = element_text(size = 10),
        axis.line = element_line(color = "black", linewidth = 0.5),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_rect(color = "black", fill = NA, linewidth = 0.5),
        plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"))
