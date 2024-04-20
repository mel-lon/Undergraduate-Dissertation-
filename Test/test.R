# Load the necessary packages
library(lme4)

# Load the dataset
file_path <- "/Users/admin/Documents/University/diss-data-collection/Classifier/Sample/finaldataset_rounded.csv"
data <- read.csv(file_path)

# Convert non-numeric values to NA in the 'engagement' column
data$engagement <- as.numeric(data$engagement)

# Drop rows with missing values
data <- na.omit(data)

# Fit the mixed effects logistic regression model
model <- glmer(Parasocial_Language~ engagement + gender + subreddit + random_speaker
               data = data)

# Print the model summary
print(summary(model))
