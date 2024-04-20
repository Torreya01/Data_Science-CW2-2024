# Load library
library(dplyr)  # Load dplyr

# Load the cleaned data
data = read.csv("data/derived/location.csv")

# Subset the data into different ranges
subset1 = data %>% filter(price >= 75000, price < 1600000)
subset2 = data %>% filter(price >= 1600000, price < 3125000)
subset3 = data %>% filter(price >= 3125000, price < 4650000)
subset4 = data %>% filter(price >= 4650000, price < 6175000)
subset5 = data %>% filter(price >= 6175000, price <= 7700000)

# Print the percentages of each subsets against the full data set
number1 = nrow(subset1)/nrow(data)*2000
number2 = nrow(subset2)/nrow(data)*2000
number3 = nrow(subset3)/nrow(data)*2000
number4 = nrow(subset4)/nrow(data)*2000
number5 = nrow(subset5)/nrow(data)*2000

# Set a seed to make the sample reproducible
set.seed(123)

# Random select data to reduce
random_subset1 = subset1[sample(nrow(subset1), number1), ]
random_subset2 = subset2[sample(nrow(subset2), number2), ]
random_subset3 = subset3[sample(nrow(subset3), number3), ]
random_subset4 = subset4
random_subset5 = subset5

# Combine the reduced subset
reduced <- rbind(random_subset1, random_subset2, random_subset3, random_subset4, random_subset5)

## Save the data
write.csv(reduced, "data/derived/location_reduced.csv", row.names = FALSE)
