# Load library
library(ggplot2)

# Load the data
data = read.csv("data/derived/location.csv")

# Determine the number of clusters
fviz_nbclust(dat[,c("lat","long")], kmeans, method = "wss")

# Perform kmeans to cluster the data into 10 clusters
m_km = kmeans(data[,c("lat","long")], 10)

# Add the cluster assignment as a factor to the data frame
data$cluster = factor(m_km$cluster)

## Save the data
write.csv(data, "Data/Derived/location_clustered.csv", row.names = FALSE)