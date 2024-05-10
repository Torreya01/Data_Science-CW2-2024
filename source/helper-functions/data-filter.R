# Load library
library(dplyr)

# Define filterdata function
filterData = function(house, priceRange, selectedClusters, yearSelect, colour_map) {
  if (yearSelect == "All") {
    # Filter data without considering the year
    filtered = house %>%
      dplyr::filter(price >= priceRange[1], price <= priceRange[2],
                    as.character(cluster) %in% selectedClusters)
  } else {
    # Filter data considering the specific year
    filtered = house %>%
      filter(date %in% yearSelect) %>%
      filter(price >= priceRange[1], price <= priceRange[2]) %>%
      filter(as.character(cluster) %in% selectedClusters)
  }
  # Map color based on cluster
  filtered$color = colour_map[as.character(filtered$cluster)]
  return(filtered)
}