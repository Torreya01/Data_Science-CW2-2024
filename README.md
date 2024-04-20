# An interactive visualisation analysing the relationship between house prices and locations in King County

## Project description

The project is designed to use RShiny to develop an interactive platform that visualizes the correlation between geographical locations and residential property prices in King County, USA. The primary aim is to enable users to explore how the location factor influence real estate values within the region. The centerpiece of the platform is a detailed map that not only displays housing prices across various areas but also allows users to engage with the data to uncover trends and insights.

## Explaining Directories

### data/

This directory contains all the raw and derived data.

-   raw data: This folder contains data for the sales, which comes from the official public records of the house sales in King County area, USA. The data contains 21613 rows, each represents a house sale from May 2014 through May 2015. The relevant data is available through [here](https://www.kaggle.com/harlfoxem/housesalesprediction).

-   derived data: This folder contains all derived data processed from the raw data by running files in source/.

### source/

-   The data-cleaning is R file that cleans and derives the data.
-   The data-reducing is R file that reduces the data.
-   The data-clustering is R file that adds cluster column to the data.

### plots/

This directory contains all the plots inserted in the application and codes.

-   codes:

    -   The histogram file contains the codes that produce the histogram figure.

    -   The cluster file contains the codes that produce the clustered figure.

    -   

-   figures:

    -   The histogram figure is the histogram of the house prices.

    -   The cluster figure is the map that divided the houses into 10 clusters.

### Application/

This is the application script.

## How to run the application

### If you have R installed

Open your R console or RStudio and paste the commands provided below.

``` r
library(shiny)
runGitHub("02439389-math70076-assessment-2", "Torreya01", launch.browser = TRUE)
```

In case R package shiny is not installed please run the following command.

``` r
install.packages("shiny", repos="http://cran.us.r-project.org")
library(shiny)
```

### If you do not have R installed

You can access to the application via this website.

## Instructions for reproducing

1.  

## Getting help

To ask a question about Shiny, please use the [RStudio Community website](https://forum.posit.co/new-topic?category=shiny&tags=shiny).

For bug reports, please use the [issue tracker](https://github.com/rstudio/shiny/issues) and also keep in mind that by [writing a good bug report](https://github.com/rstudio/shiny/wiki/Writing-Good-Bug-Reports), you're more likely to get help with your problem.
