# Import library
library(ggplot2)

# Load the data
clustering = read.csv("data/dervied/location_clustering.csv")


ggplot(aes(x = long,y = lat),data = data_reduced) + 
  geom_point(col = factor(m_km$cluster)) + coord_map()
