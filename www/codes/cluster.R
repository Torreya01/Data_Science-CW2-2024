# Load library
library(ggplot2)

# Load the data
clustered = read.csv("data/derived/location_clustered.csv")

# Convert 'cluster' to a factor if it's not already
clustered$cluster = as.factor(clustered$cluster)

# Define a color palette with 10 different colors
color_palette = c("#1F77B4", "#FF7F0E", "#2CA02C", "#D62728", "#9467BD", 
                   "#8C564B", "#E377C2", "#7F7F7F", "#BCBD22", "#17BECF")

# Create the plot
cluster = ggplot(clustered, aes(x = long, y = lat, color = cluster)) + 
  geom_point() +
  # Set the color manually
  scale_color_manual(values = color_palette) +
  # Add the map
  coord_map() + 
  # Add plot title
  labs(title = "House clusters",
       # Label for x-axis
       x = "Longtitude",
       # Label for y-axis
       y = "Latitude")

# Save the plot
ggsave(filename = "Cluster.png",
       plot = cluster,
       device = 'png', 
       path = "Plots/Figures",
       width = 8,   # Width of the plot in inches
       height = 6,  # Height of the plot in inches
       dpi = 300)
