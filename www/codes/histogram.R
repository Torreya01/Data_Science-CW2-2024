# Load library
library(ggplot2)

# Load the reduced data
reduced = read.csv("data/derived/location_reduced.csv")

# Calculate the density
density_data = density(reduced$price, adjust = 4)
max_density_x = density_data$x[which.max(density_data$y)]
max_density_y = max(density_data$y)

# Create a data frame for the vertical line
line_data = data.frame(x = c(max_density_x, max_density_x), 
                       y = c(0, max_density_y))

# Create histogram with ggplot
hist = ggplot(reduced, aes(x = price)) +
  # Normalise the histogram
  geom_histogram(aes(y = after_stat(density)),
                 # Adjust binwidth to the scale of the data
                 binwidth = 50000,
                 color = "black", fill = "lightblue", alpha = 0.7) +
  # Add density plot
  geom_density(aes(y = after_stat(density)),  
               # Adjust the color of the density curve
               color = "red", 
               # Adjust the size of the density curve
               linewidth = 1,
               # Adjust the smoothing parameter for density
               adjust = 4) + 
  # Add vertical line at max density
  geom_segment(aes(x = x, y = 0, xend = x, yend = y), 
               data = line_data,
               color = "blue", size = 1, linetype = "dashed") +
  # Add label max density
  geom_text(aes(x = max_density_x, y = 0, label = round(max_density_x, 2)), 
            color = "blue", size = 3, vjust = 1.5) +
  # Add plot title
  labs(title = "Price Distribution",
       # Label for x-axis
       x = "Price for houses in King County",
       # Label for y-axis
       y = "Density") +   
  # Adjust the y-axis limits as needed
  scale_y_continuous(limits = c(0, 0.000003))

# Save the plot
ggsave(filename = "Histogram.png",
       plot = hist,
       device = 'png', 
       path = "www/figures",
       width = 8,   # Width of the plot in inches
       height = 6,  # Height of the plot in inches
       dpi = 300)

