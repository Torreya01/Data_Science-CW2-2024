library(ggplot2)

# Load the data
data_reduced <- read.csv("data/derived/location.csv")

# Determine the number of clusters
fviz_nbclust(data_reduced[,c("lat","long")], kmeans, method = "wss")

# Perform kmeans to cluster the data into 10 clusters
m_km = kmeans(data_reduced[,c("lat","long")], 10)

# Add the cluster assignment as a factor to the data frame
data_reduced$cluster = factor(m_km$cluster)

## Save the data
write.csv(data_reduced, "Data/Derived/location_clustered.csv", row.names = FALSE)
