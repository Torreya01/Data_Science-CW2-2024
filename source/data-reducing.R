# Load library
library(dplyr)

# Load the cleaned data
data = read.csv("data/derived/location_clustered.csv")

# Subset the data into different ranges
subset1 = data %>% filter(cluster == 1)
subset2 = data %>% filter(cluster == 2)
subset3 = data %>% filter(cluster == 3)
subset4 = data %>% filter(cluster == 4)
subset5 = data %>% filter(cluster == 5)
subset6 = data %>% filter(cluster == 6)
subset7 = data %>% filter(cluster == 7)
subset8 = data %>% filter(cluster == 8)
subset9 = data %>% filter(cluster == 9)
subset10 = data %>% filter(cluster == 10)

# Print the percentages of each subsets against the full data set
number1 = nrow(subset1)/nrow(data)*2000
number2 = nrow(subset2)/nrow(data)*2000
number3 = nrow(subset3)/nrow(data)*2000
number4 = nrow(subset4)/nrow(data)*2000
number5 = nrow(subset5)/nrow(data)*2000
number6 = nrow(subset6)/nrow(data)*2000
number7 = nrow(subset7)/nrow(data)*2000
number8 = nrow(subset8)/nrow(data)*2000
number9 = nrow(subset9)/nrow(data)*2000
number10 = nrow(subset10)/nrow(data)*2000

# Set a seed to make the sample reproducible
set.seed(123)

# Random select data to reduce
random_subset1 = subset1[sample(nrow(subset1), number1), ]
random_subset2 = subset2[sample(nrow(subset2), number2), ]
random_subset3 = subset3[sample(nrow(subset3), number3), ]
random_subset4 = subset4[sample(nrow(subset4), number4), ]
random_subset5 = subset5[sample(nrow(subset5), number5), ]
random_subset6 = subset6[sample(nrow(subset6), number6), ]
random_subset7 = subset7[sample(nrow(subset7), number7), ]
random_subset8 = subset8[sample(nrow(subset8), number8), ]
random_subset9 = subset9[sample(nrow(subset9), number9), ]
random_subset10 = subset10[sample(nrow(subset10), number10), ]

# Combine the reduced subset
reduced <- rbind(random_subset1, random_subset2, random_subset3, random_subset4, random_subset5,
                 random_subset6, random_subset7, random_subset8, random_subset9, random_subset10)

## Save the data
write.csv(reduced, "data/derived/location_reduced.csv", row.names = FALSE)
