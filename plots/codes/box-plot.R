# Load library
library(ggplot2)

# Load your data (assuming your data frame is named 'data_frame')
data = read.csv("data/derived/location_clustered.csv")

# Create the boxplot using ggplot
ggplot(data, aes(x = factor(cluster), y = price)) + 
  # Add box plot
  geom_boxplot() +
  # Add plot title
  labs(title = "Box plot for each clusters",
       # Label for x-axis
       x = "Clusters",
       # Label for y-axis
       y = "Prices") +  
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))  # If cluster names are long

# Save the plot
ggsave(filename = "Box-plot.png",
       plot = box,
       device = 'png', 
       path = "Plots/Figures",
       width = 8,   # Width of the plot in inches
       height = 6,  # Height of the plot in inches
       dpi = 300)