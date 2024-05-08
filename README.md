# An interactive visualisation analysing the relationship between house prices and locations in King County

## Project description

The project is designed to use RShiny to develop an interactive platform that visualizes the correlation between geographical locations and residential property prices in King County, USA. The primary aim is to enable users to explore how the location factor influence real estate values within the region. The centerpiece of the platform is a detailed map that not only displays housing prices across various areas but also allows users to engage with the data to uncover trends and insights.

## Explaining Directories

### data/

This directory contains all the raw and derived data.

-   raw: This folder contains data for the sales, which comes from the official public records of the house sales in King County area, USA. The data contains 21613 rows, each represents a house sale from May 2014 through May 2015. The relevant data is available through [here](https://www.kaggle.com/harlfoxem/housesalesprediction).

-   derived: This folder contains all derived data processed from the raw data by running files in source/.

### source/

-   data-processing/

    -   The data-cleaning.R cleans and derives the data.

    -   The data-clustering .R adds cluster column to the data.

-   helper-functions/

    -   The box-plot.R creates box plots used in app.

    -   The colour-patterns.R contains the cluster colours used in map.

    -   The density-plot.R creates density plots used in app.

    -   The map.R creates map of King County.

### www/

This directory contains all the images downloaded from internet. To ensure the validity, all images were taken after the year 2022.

-   The street-view-1.png is the street view of the most expensive house in cluster 9 can be found [here](https://www.google.com/maps/@47.6299522,-122.3223733,3a,75y,114.42h,91.38t/data=!3m6!1e1!3m4!1sr65xGU9EfLv60UohDKQapQ!2e0!7i16384!8i8192?entry=ttu) from Google map.

-   The street-view-2.png is the street view of the most expensive house in cluster 7 can be found [here](https://www.google.co.uk/maps/@47.6496913,-122.2151528,3a,75y,235.11h,82.3t/data=!3m6!1e1!3m4!1sDaM6ZBHsQBcyPBi4FcmUiA!2e0!7i16384!8i8192?entry=ttu) from Google map.

-   The street-view-3.png is the street view of the most expensive house in cluster 3 can be found [here](https://www.google.co.uk/maps/@47.5629133,-122.2114549,3a,75y,53.06h,84.79t/data=!3m6!1e1!3m4!1sF5FrTXI2ygTIXr7n8yyIcQ!2e0!7i16384!8i8192?entry=ttu) from Google map.

-   The water-view-1.png is the view of Lake union can be found [here](https://www.google.co.uk/maps/place/Lake+Union/@47.6396286,-122.3332684,5a,73.9y/data=!3m8!1e2!3m6!1sAF1QipPVH1BumadJeva00xEQ_WZAXwJhtZd1GPTxbPXZ!2e10!3e12!6shttps:%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipPVH1BumadJeva00xEQ_WZAXwJhtZd1GPTxbPXZ%3Dw203-h152-k-no!7i4032!8i3024!4m7!3m6!1s0x5490150855d85f3f:0xeb5feb67cd0a7b6d!8m2!3d47.6396286!4d-122.3332684!10e5!16zL20vMDFnOGh0?entry=ttu) from Google map.

-   The water-view-2.png is the view of Lake Washington can be found [here](https://www.google.co.uk/maps/place/Lake+Washington/@47.6215474,-122.255756,3a,75y,90t/data=!3m8!1e2!3m6!1sAF1QipOBU9Umz-0jlGkh2PpNPL2Ob1hewCQe4TEpUKek!2e10!3e12!6shttps:%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipOBU9Umz-0jlGkh2PpNPL2Ob1hewCQe4TEpUKek%3Dw203-h135-k-no!7i1620!8i1080!4m9!3m8!1s0x549014cd737a0137:0x9069059ce509d017!8m2!3d47.6215474!4d-122.255756!10e5!14m1!1BCgIgAQ!16zL20vMDFnM3Zu?entry=ttu) from Google map.

-   The water-view-3.png is the view of Lake Washington can be found [here](https://www.google.co.uk/maps/place/Lake+Washington/@47.7568101,-122.2634396,3a,75y,83.92h,89.23t/data=!3m8!1e1!3m6!1sAF1QipMUbQ9377T5huboaJ0smJjbswv-Z8rPpGVGVVwN!2e10!3e11!6shttps:%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipMUbQ9377T5huboaJ0smJjbswv-Z8rPpGVGVVwN%3Dw203-h100-k-no-pi-0-ya98.93163-ro-0-fo100!7i7168!8i3584!4m19!1m9!3m8!1s0x54905c8c832d7837:0xe280ab6b8b64e03e!2sKing+County,+WA,+USA!3b1!8m2!3d47.5480339!4d-121.9836029!10e5!16zL20vMG1tcHo!3m8!1s0x549014cd737a0137:0x9069059ce509d017!8m2!3d47.6215474!4d-122.255756!10e5!14m1!1BCgIgARICCAI!16zL20vMDFnM3Zu?entry=ttu) from Google map.

### app/

This is the application script with comment.

## How to run the application

### If you have R installed

Open your R console or RStudio and paste the commands provided below.

``` r
library(shiny)
runGitHub("Data_Science-CW2-2024", "Torreya01", launch.browser = TRUE)
```

In case R package shiny is not installed please run the following command.

``` r
install.packages("shiny", repos = "http://cran.us.r-project.org")
```

### If you do not have R installed

You can access to the application via the website here.

## Instructions for reproducing

1.  Obtain data. (you may find it [here](https://www.kaggle.com/harlfoxem/housesalesprediction) again)

2.  Run files in source/data-processing in following order to obtain the derived data.

    -   data-cleaning.R

    -   data-clustering.R

3.  Run the application using the instruction above.

## Getting help

To ask a question about Shiny, please use the [RStudio Community website](https://forum.posit.co/new-topic?category=shiny&tags=shiny).

For bug reports, please use the [issue tracker](https://github.com/rstudio/shiny/issues) and also keep in mind that by [writing a good bug report](https://github.com/rstudio/shiny/wiki/Writing-Good-Bug-Reports), you're more likely to get help with your problem.
