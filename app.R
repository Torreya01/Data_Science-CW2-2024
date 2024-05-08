# Load libraries
library(shiny)
library(leaflet)
library(dplyr)
library(DT)
library(bslib)

# Source the helper functions
source("source/helper-functions/density-plot.R")
source("source/helper-functions/box-plot.R")
source("source/helper-functions/colour-patterns.R")
source("source/helper-functions/map.R")

# Define UI
ui = navbarPage("House Prices in King County",
                theme = bs_theme(version = 5, bootswatch = "minty"),
                tabPanel("Map",
                         sidebarLayout(
                           sidebarPanel(
                             sliderInput("priceRange",
                                         "Price Range:",
                                         min = 0,
                                         max = 1,
                                         value = c(0, 1),
                                         step = 50000,
                                         pre = "$"),
                             selectInput("yearSelect", "Select Year:",
                                         choices = c("2014", "2015", "All")),
                             checkboxGroupInput("selectedClusters",
                                                "Select Clusters:",
                                                choices = as.character(1:10),
                                                selected = 1:10,
                                                inline = TRUE),
                             plotOutput("mapdensity")
                           ),
                            mainPanel(
                              h3("Houses on the map of King County"),
                              
                              p("The application shows the houses in King County 
                              and you can adjust the pices range via the slider. 
                              The houses have been divided into 10 sections and 
                              you can select a specific cluster to look at the 
                              prices individually. I also present some analysis 
                              of the house prices."),
                              
                              leafletOutput("map"),  # Placeholder for the leaflet map
                              
                              tags$h4(style = "color: red;", "Warning:"),
                              
                              p("Due to the large data set, the application may 
                              be slow to run, please be patient when the application
                              is running."), 
                              
                              p("The plot is a scatterplot visualizing house data from King County, plotted by latitude and longitude, 
                          categorized into 10 different clusters via k-means. Each cluster 
                          is represented by a unique color. K-means is a popular clustering algorithm 
                          used in data analysis and machine learning to partition a set of observations 
                          into a specified number of clusters, where each observation belongs 
                          to the cluster with the nearest mean."),
                              
                              p("Some clusters like 3, 5, 7 and 9 are more densely packed, indicating
                          areas with high housing density or popular residential areas. Other clusters
                          are more spread out, which reflects the population density 
                          or the type of housing available in those areas are not that many. Especially for 
                          cluster 1 and 4, they have less houses in these regions and might represent
                          suburban or rural areas for these clusters."),
                              
                              p("Cluster 10 appears quite isolated and far from 
                          other clusters, located at higher latitudes and longitudes. This might indicate
                          a unique geographic or socioeconomic area. We can see on the map that it could be
                          a distinct community separated from central urban areas."),
                            )
                          )),
                
                tabPanel("Density plot",
                         h3("Density plot with a density curve"),
                         
                         p("The x-axis represents the price of houses in King County, 
                          the y-axis represents the density of the distribution, showing
                          how the data is distributed along different price points.
                          The bars of the histogram show the frequency or density of houses
                          within specific price ranges. A taller bar indicates that more 
                          houses are priced within that range compared to shorter bars."),
                         
                         p("There is a density curve, which helps visualize the distribution's 
                          shape and spread. The peak corresponds to the mode of the distribution.
                          In this plot, the mode of the distribution is around 427991.43, 
                          where most prices distributed."),
                         
                         p("Below you can choose individual clusters or all clusters
                          simultaneously and compare the density plots. We can instantly
                          see and compare how price distributions differ by area."),
                         
                         fluidRow(
                           column(6,  # First column for dynamic density plots
                                  h4("Density plot for cluster choosing below"),
                                  selectInput("clusterSelection1", "Choose a Cluster:",
                                              choices = c("All", as.character(1:10))),
                                  plotOutput("densityPlot1", width = "100%", height = "400px")),
                           column(6,  # Second column for static image
                                  h4("Density plot for cluster choosing below"),
                                  selectInput("clusterSelection2", "Choose a Cluster:",
                                              choices = c("All", as.character(1:10))),
                                  plotOutput("densityPlot2", width = "100%", height = "400px"))
                         ),
                         
                         p("After exploring the densities for each clusters, the mode of the
                          house prices is higher for clusters 1, 2, 3, 7, 9 and 10 compared to 
                          the mode of the aggregated data from all clusters. Specifically, 
                          the peak densities observed in the distributions of clusters 1, 2, 3, 
                          7, 9 and 10 occur at higher price values than the peak density of the
                          combined dataset. This implies that the most common house prices in 
                          these clusters are significantly above the most common house prices 
                          observed across the entire dataset. This observation may reflect 
                          localized economic conditions or property features in these clusters
                          that elevate property values more than in other areas.")
                         
                ),
                          
                tabPanel("Box plot",
                         fluidRow(
                           column(12, 
                                  selectInput("yearInput", 
                                              "Select Year:", 
                                              choices = c(2014, 2015),
                                              selected = 2014))),
                         fluidRow(
                           column(12,
                                  plotOutput("boxplot", width = "100%"))),
                          
                          p("Through the box plot of the data, I can visualize the distribution
                          of house prices across 10 different clusters."),
                          
                          p("Clusters 3, 7 and 9 have a high variability in house prices, 
                          with a wide range and several outliers. The outliers are high 
                          price points, indicating that there are some houses that are 
                          much more expensive than the typical house in the cluster. 
                          Clusters like 4, 6, 8, and 10 seem to have a lower variability, 
                          with narrower boxes and fewer outliers."),
                          
                          p("Natually, it raises the question: what will affect the prices 
                          and why are these houses so expensive?")),
                 
                 tabPanel("Living Environment",
                          p("Environment around the houses can be a great impact of the prices.
                          Houses located in a nice neighbourhood will have higher prices. Below are 
                          the environmental analysis of the most three most expensive houses located in cluster 3, 
                          7 and 9."),
                          
                          h3("Street views of the houses"),
                          
                          fluidRow(
                            column(4,
                              div(style = "text-align: center;",  # Center the image and caption
                                       img(src = "figures-from-internet/Street-View-1.png", height = "100%", width = "100%"),
                                       p("Street view of the most expensive house in cluster 9"))),
                            column(4,
                                   div(style = "text-align: center;",  # Center the image and caption
                                       img(src = "figures-from-internet/Street-View-2.png", height = "100%", width = "100%"),
                                       p("Street view of the most expensive house in cluster 7"))),
                            column(4,
                                   div(style = "text-align: center;",  # Center the image and caption
                                       img(src = "figures-from-internet/Street-View-3.png", height = "100%", width = "100%"),
                                       p("Street view of the most expensive house in cluster 3")))
                          ),
                          
                          p("Based on these street views, all three images depict residential 
                          settings characterized by single-family homes, which suggest a 
                          primarily residential neighborhood rather than mixed-use or commercial
                          areas."),
                          
                          p("There is an abundance of greenery visible in all three properties, 
                          they all have beautiful lawns, trees, and other plants. This landscaping
                          adds aesthetic value to the properties and suggests a well-maintained 
                          and possibly affluent area.The houses shown feature distinct architectural
                          styles but are all representative of typical suburban family homes, with 
                          elements like multiple stories, garages, and spacious front yards."),
                          
                          h3("Water views of the houses"),
                          
                          fluidRow(
                            column(4,
                                   div(style = "text-align: center;",  # Center the image and caption
                                       img(src = "figures-from-internet/Water-View-1.png", height = "100%", width = "100%"),
                                       p("Water view of Lake Union"))),
                            column(4,
                                   div(style = "text-align: center;",  # Center the image and caption
                                       img(src = "figures-from-internet/Water-View-2.png", height = "100%", width = "100%"),
                                       p("Water view of Lake Washington"))),
                            column(4,
                                   div(style = "text-align: center;",  # Center the image and caption
                                       img(src = "figures-from-internet/Water-View-3.png", height = "100%", width = "100%"),
                                       p("Water view of Lake Washington")))
                          ),
                          
                          p("These three houses are all located nearby lakes, one is 
                          near to Lake Union and two are near to Lake Washington. Waterfront 
                          properties are limited in number and offer unique, often unobstructed,
                          views of the water. The exclusivity of these views and direct access 
                          to water significantly contribute to their high prices.")),
                
                 tabPanel("Transportation",
                          h3("Nearby Transportations"),
                          p("Details about the transportation..."))
)

# Define server
server = function(input, output, session) {
  
  # Read data from a CSV file
  house = read.csv("data/derived/location_clustered.csv", stringsAsFactors = FALSE)
  
  # Map clusters to colours
  colour_map = setNames(colour_choice, unique(house$cluster))
  
  observe({
    if (input$yearSelect == "All") {
      updateSliderInput(session, "priceRange",
                        min = min(house$price, na.rm = TRUE),
                        max = max(house$price, na.rm = TRUE),
                        value = c(min, max))
    } 
    else {
      updateSliderInput(session, "priceRange",
                        min = min(house$price[house$date == input$yearSelect], na.rm = TRUE),
                        max = max(house$price[house$date == input$yearSelect], na.rm = TRUE),
                        value = c(min, max))
    }
  })
  
  
  # Update reactive expression for filtered data
  filteredData = reactive({
    if (input$yearSelect == "All") {
      # Filter data without considering the year
      filtered = house %>%
        filter(price >= input$priceRange[1], price <= input$priceRange[2],
               as.character(cluster) %in% input$selectedClusters)
    } 
    else {
    filtered = house %>%
      filter(date %in% input$yearSelect) %>%
      filter(price >= input$priceRange[1], price <= input$priceRange[2]) %>%
      filter(as.character(cluster) %in% input$selectedClusters)
    }
    # Map color based on cluster
    filtered$color = colour_map[as.character(filtered$cluster)]
    filtered
  })
  
  # Render the map output
  output$map = renderLeaflet({
    mapproduce(filteredData())
  })
  
  output$mapdensity = renderPlot({
    densityplot(filteredData())
  })
  
  output$densityPlot1 = renderPlot({
    data = house
    if (input$clusterSelection1 != "All") {
      data = data[data$cluster == as.numeric(input$clusterSelection1), ]
    }
    densityplot(data, input$clusterSelection1)
  })
  
  output$densityPlot2 = renderPlot({
    data = house
    if (input$clusterSelection2 != "All") {
      data = data[data$cluster == as.numeric(input$clusterSelection2), ]
    }
    densityplot(data, input$clusterSelection2)
  })
  
  output$boxplot = renderPlot({
    data = house
    data = data[data$date == as.numeric(input$yearInput), ]
    boxplot(data, input$yearInput)
  })
  
}

# Run the application 
shinyApp(ui, server)
