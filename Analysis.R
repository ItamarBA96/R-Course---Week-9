# Script Name: Analysis.R
# R course for beginners, Tel Aviv University
# Author: Itamar Ben Arie
# Date: 2025-01-07

# Data Frame
N <- 30
df <- data.frame(                                                      
  participant_id = 1:N, 
  age = sample(18:60, N, replace = TRUE), 
  gender = factor(sample(c("male", "female"), N, replace = TRUE)),
  reaction_time = runif(N, 200, 6000),  
  depression = runif(N, 0, 100),  
  sleep_time = runif(N, 2, 12) 
)
print(df)

# Save the data frame to a CSV file
write.csv(df, "analysis.csv", row.names = FALSE)

# Load the function from the external file
source("Functions.R")

# Use the function with a specific range
results <- generate_descriptive_stats(df, subject_start = 5, subject_end = 15)
print(results)
