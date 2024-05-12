# Import packages
library(dplyr)
library(tidyverse)

# Import data set from the raw data folder
data = read.csv("data/raw/kc_house_data.csv", header = TRUE)

# Extract data that only contains the house prices and location information
data_loc = data %>% select("price", "date", "lat", "long")

# Extract the year and convert it to integer
data_loc = data_loc %>%
  mutate(date = as.integer(substr(date, 1, 4)))

# Omit the NAs from the data we derived from the raw dataset
data_loc = na.omit(data_loc)

## Save the data
write.csv(data_loc, "Data/Derived/location.csv", row.names = FALSE)