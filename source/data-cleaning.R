# Import packages
library(dplyr)
library(tidyverse)

# Import dataset from the raw data folder
data = read.csv("data/raw/kc_house_data.csv", header = TRUE)

################################################################################

# The codes below are used for extracting data for RShiny app

## Extract data that only contains the house prices and location information
data_loc = data %>% select("price", "lat", "long")

## Omit the NAs from the data we derived from the raw dataset
data_loc = na.omit(data_loc)

## Save the data
write.csv(data_loc, "Data/Derived/location.csv", row.names = FALSE)
