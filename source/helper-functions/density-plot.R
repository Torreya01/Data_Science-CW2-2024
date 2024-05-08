# Load libraries
library(ggplot2)

# Define density plot function
densityplot = function(data, input = ""){
  # Calculate the density
  density_data = density(data$price, adjust = 4)
  max_density_x = density_data$x[which.max(density_data$y)]
  max_density_y = max(density_data$y)
  # Create a data frame for the vertical line
  line_data = data.frame(x = c(max_density_x, max_density_x), 
                         y = c(0, max_density_y))
  
  # Generate the density plot
  ggplot(data, aes(x = price)) +
    # Normalise the histogram
    geom_histogram(aes(y = after_stat(density)),
                   # Adjust binwidth to the scale of the data
                   binwidth = 50000,
                   color = "black", fill = "lightblue", alpha = 0.7) +
    geom_density(aes(y = after_stat(density)),  
                 # Adjust the color of the density curve
                 color = "red", 
                 # Adjust the size of the density curve
                 linewidth = 1,
                 # Adjust the smoothing parameter for density
                 adjust = 4) + 
    labs(title = if (input == ""){
      paste("Density Plot")}
      else 
        {
        paste("Density Plot for Cluster", input)
          },
         x = "Price",
         y = "Density") +
    # Add vertical line at max density
    geom_segment(aes(x = x, y = 0, xend = x, yend = y), 
                 data = line_data,
                 color = "blue", linewidth = 1, linetype = "dashed") +
    # Add label max density
    geom_text(aes(x = max_density_x, y = 0, label = round(max_density_x, 2)), 
              color = "blue", size = 3, vjust = 1.5)
}