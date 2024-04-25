



# Plot the p-values as a bar chart
ggplot(results[-1, ], aes(x = Predictor, y = P_Value, fill = P_Value < 0.05)) +
  geom_bar(stat = "identity", width = 0.5, color = "black") +
  geom_text(aes(label = ifelse(P_Value < 0.05, "*", "")), vjust = -0.3, size = 5, fontface = "bold") +
  labs(title = "P-values of Predictors in Linear Regression Model",
       x = "Predictor",
       y = "p-value") +
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
        panel.background = element_rect(fill = "white")) +
  geom_hline(yintercept = 0.05, color = "red", linetype = "dashed", size = 1)  # Add dashed red line at y=0.05 significance level
