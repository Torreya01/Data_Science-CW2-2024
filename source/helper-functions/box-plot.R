# Load library
library(ggplot2)

# Define box plot function
boxplot = function(data, input = ""){
  ggplot(data, aes(x = factor(cluster), y = price)) + 
    
  # Add box plot
  geom_boxplot() +
    
  # Add plot title
  labs(title = paste("Box-plot For Each Clusters In Year", input),
       x = "Clusters",
       y = "Prices") +  
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
}