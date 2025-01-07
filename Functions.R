# Function to calculate descriptive statistics with conditions at the end
generate_descriptive_stats <- function(data, 
                                       subject_start = min(data$participant_id), 
                                       subject_end = max(data$participant_id)) {
  # Create an empty data frame to store statistics
  stats <- data.frame(Variable = character(), Type = character(), Details = character())
  
  # Loop through each column in the full data
  for (var in names(data)) {
    if (is.numeric(data[[var]])) {
      # Numeric variable: calculate mean, min, max
      details <- paste0("Mean: ", round(mean(data[[var]], na.rm = TRUE), 2), 
                        ", Min: ", min(data[[var]], na.rm = TRUE), 
                        ", Max: ", max(data[[var]], na.rm = TRUE))
      stats <- rbind(stats, data.frame(Variable = var, Type = "Numeric", Details = details))
    } else if (is.factor(data[[var]]) || is.character(data[[var]])) {
      # Categorical variable: count levels
      levels_count <- table(data[[var]])
      details <- paste(names(levels_count), levels_count, sep = ": ", collapse = "; ")
      stats <- rbind(stats, data.frame(Variable = var, Type = "Categorical", Details = details))
    }
  }
  
  # Condition 1: Check if the data has fewer than 10 rows
  if (nrow(data) < 10) {
    stop("data is too short")  # Print error and stop execution
  }
  
  # Condition 2: Filter the data based on the subject range
  filtered_data <- data[data$participant_id >= subject_start & data$participant_id <= subject_end, ]
  
  # Condition 3: Check if there are any rows after filtering
  if (nrow(filtered_data) == 0) {
    stop("No data in the specified subject range")  # Print error if no data
  }
  
  # Create an empty data frame to store statistics for filtered data
  filtered_stats <- data.frame(Variable = character(), Type = character(), Details = character())
  
  # Loop through each column in the filtered data
  for (var in names(filtered_data)) {
    if (is.numeric(filtered_data[[var]])) {
      # Numeric variable: calculate mean, min, max
      details <- paste0("Mean: ", round(mean(filtered_data[[var]], na.rm = TRUE), 2), 
                        ", Min: ", min(filtered_data[[var]], na.rm = TRUE), 
                        ", Max: ", max(filtered_data[[var]], na.rm = TRUE))
      filtered_stats <- rbind(filtered_stats, data.frame(Variable = var, Type = "Numeric", Details = details))
    } else if (is.factor(filtered_data[[var]]) || is.character(filtered_data[[var]])) {
      # Categorical variable: count levels
      levels_count <- table(filtered_data[[var]])
      details <- paste(names(levels_count), levels_count, sep = ": ", collapse = "; ")
      filtered_stats <- rbind(filtered_stats, data.frame(Variable = var, Type = "Categorical", Details = details))
    }
  }
  
  # Return the statistics data frame for filtered data
  return(filtered_stats)
}


# Example usage with specified range
results <- generate_descriptive_stats(df, subject_start = 5, subject_end = 15)
print(results)
