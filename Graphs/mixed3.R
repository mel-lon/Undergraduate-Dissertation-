# Load the required packages
library(lme4)
library(webshot)
library(knitr)
library(kableExtra)

# Load the dataset
file_path <- "/Users/admin/Documents/University/diss-data-collection/Classifier/Sample/processed_utterances_with_date.csv"
data <- read.csv(file_path)

# Calculate log_engagement from score and num_comments
data$log_engagement <- log(data$score + data$num_comments + 1)

# Construct the mixed regression model
mixed_model <- lmer(log_engagement ~ PSR + top_level_comment + has_flair + is_stickied + (1 | random_speaker) + (1 | date), data = data)

# Get the coefficient estimates and standard errors
summary_data <- summary(mixed_model)$coefficients

# Convert to dataframe
summary_df <- as.data.frame(summary_data)

# Save the summary table as an image
summary_html <- kable(summary_df, "html") %>%
  kable_styling(full_width = FALSE) %>%
  as.character()

# Save as HTML
writeLines(summary_html, "mixed_regression_summary.html")

# Convert HTML to image
webshot("mixed_regression_summary.html", "mixed_regression_summary.png")
