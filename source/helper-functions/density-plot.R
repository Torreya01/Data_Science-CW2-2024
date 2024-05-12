# Load library
library(ggplot2)

# Define density plot function
densityplot = function(data, input = ""){
  # Ensure price is a numeric vector and not a list
  if (is.list(data$price)) {
    data$price <- unlist(data$price)
  }
  
  # Check if there are enough data points
  if (length(na.omit(data$price)) < 2) {
    stop("Not enough data points to compute density.")
  }
  
  # Calculate the density
  density_data = density(data$price, adjust = 4)
  max_density_x = density_data$x[which.max(density_data$y)]
  max_density_y = max(density_data$y)
  
  # Create a data frame for the vertical line
  line_data = data.frame(x = c(max_density_x, max_density_x), 
                         y = c(0, max_density_y))
  
  # Generate the density plot
  ggplot(data, aes(x = price)) +
    geom_histogram(aes(y = after_stat(density)),
                   binwidth = 50000,
                   color = "black", fill = "lightblue", alpha = 0.7) +
    geom_density(aes(y = after_stat(density)),  
                 color = "red", 
                 linewidth = 1,
                 adjust = 4) + 
    labs(title = if (input == ""){
      paste("Density Plot for Selected Data")}
      else {
        paste("Density Plot for Cluster", input)
      },
         x = "Price",
         y = "Density") +
    geom_segment(aes(x = x, y = 0, xend = x, yend = y), 
                 data = line_data,
                 color = "blue", linewidth = 1, linetype = "dashed") +
    geom_text(aes(x = max_density_x, y = 0, label = round(max_density_x, 2)), 
              color = "blue", size = 3, vjust = 1.5)
}
