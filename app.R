# Load necessary libraries
# Load libraries
library(shiny)
library(leaflet)
library(dplyr)
library(DT)
library(bslib)
library(ggplot2)

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
                              div(style = "display: 2:5; flex-wrap: wrap;",
                                  checkboxGroupInput("selectedClusters",
                                                     "Select Clusters:",
                                                     choices = as.character(1:10),
                                                     selected = 1:10,
                                                     inline = TRUE)
                              )
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
                              
                              h3("Data Selection"),
                              
                              p("The minimum of the data set is 75000 and the maximum
                              is 7700000. Since the full data set has 21613 observations,
                              which is too big for the application to operate. 
                              Therefore, I reduced the data set into 1997 observations."),
                              
                              p("I splitted the data into 10 clusters: I assign 2000 
                              observtions based on the percentages. However, due to the 
                              decimal points when calculating the percentages for each 
                              clusters, the total observations would be 1997. 
                              For simplicity, I will look into the reduced data set 
                              instead of the full data set."),
                            )
                          )),
                
                tabPanel("Density plot",
                         h3("Density plot with a density curve"),
                         
                         div(style = "text-align: center;",  # Center the image and caption
                             img(src = "figures/Histogram.png", height = "600px", width = "800px"),
                             p("Histogram of the house prices with density in King County, USA")
                         ),
                         
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
                          
                 tabPanel("Non-Parametric Analysis",
                          p("Below are some non-parametric statistical analysis about the 
                            house data. We will first look at how 10 different clusters are 
                            located in the map, and then discuss the density of the whole
                            data set. Finally, we will look at a box plot for each clusters 
                            so that we can find out which region has the most expensive houses
                            and look for the reasons."),
                          
                          h3("10 different house clusters"),
                          
                          div(style = "text-align: center;",  # Center the image and caption
                              img(src = "figures/Cluster.png", height = "600px", width = "800px"),
                              p("10 different clusters shown on the King County map")),
                          
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
                          
                          h3("The boxplot for 10 different clusters"),
                          
                          div(style = "text-align: center;",  # Center the image and caption
                              img(src = "figures/Box.png", height = "600px", width = "800px"),
                              p("Box plot of the clusters showing differnt variability")
                           ),
                          
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
  house = read.csv("data/derived/location_reduced.csv", stringsAsFactors = FALSE)
  
  # Observe changes in data and update the slider accordingly
  observe({
    updateSliderInput(session, "priceRange",
                      min = min(house$price, na.rm = TRUE),
                      max = max(house$price, na.rm = TRUE),
                      value = c(min(house$price, na.rm = TRUE), max(house$price, na.rm = TRUE)))
    
    updateCheckboxGroupInput(session, "selectedClusters",
                             choices = levels(factor(house$cluster)),
                             selected = levels(factor(house$cluster)))
  })

  # Update reactive expression for filtered data
  filteredData = reactive({
    house %>%
      filter(price >= input$priceRange[1], price <= input$priceRange[2]) %>%
      filter(as.character(cluster) %in% input$selectedClusters)  # Filter for selected clusters
  })
  
  # Render the map output
  output$map = renderLeaflet({
    filtered_data = filteredData()  # Get filtered data based on slider input
    
    # Define the bounds for King County to restrict the map view
    bounds = list(
      southWest = list(lat = 47.2, lng = -122.5),
      northEast = list(lat = 47.9, lng = -121.5)
    )
    
    # Create the map with initial view settings
    map = leaflet(filtered_data) %>%
      addTiles() %>%
      setView(lng = -121.9836, lat = 47.5480, zoom = 9) %>%
      setMaxBounds(lng1 = bounds$southWest$lng, lat1 = bounds$southWest$lat,
                   lng2 = bounds$northEast$lng, lat2 = bounds$northEast$lat)
    
    # Add markers to the map if data is available
    if(nrow(filtered_data) > 0) {  
      map = map %>% addMarkers(~long, ~lat, popup = ~paste("Price: $", price))
    }
    
    map  # Return the map object
  })
  
  output$densityPlot1 = renderPlot({
    
    # Filter data based on the selected cluster
    data = house
    if (input$clusterSelection1 != "All") {
      data = data[data$cluster == as.numeric(input$clusterSelection1), ]
    }
    
    # Calculate the density
    density_data = density(data$price, adjust = 4)
    max_density_x = density_data$x[which.max(density_data$y)]
    max_density_y = max(density_data$y)
    # Create a data frame for the vertical line
    line_data = data.frame(x = c(max_density_x, max_density_x), 
                           y = c(0, max_density_y))
    
    # Generate the density plot
    ggplot(data, aes(x = price)) +
      # Normalise the histogram
      geom_histogram(aes(y = after_stat(density)),
                     # Adjust binwidth to the scale of the data
                     binwidth = 50000,
                     color = "black", fill = "lightblue", alpha = 0.7) +
      geom_density(aes(y = after_stat(density)),  
               # Adjust the color of the density curve
               color = "red", 
               # Adjust the size of the density curve
               linewidth = 1,
               # Adjust the smoothing parameter for density
               adjust = 4) + 
      labs(title = paste("Density Plot for Cluster", input$clusterSelection1),
           x = "Price",
           y = "Density") +
      xlim(0, 8000000) +
      # Add vertical line at max density
      geom_segment(aes(x = x, y = 0, xend = x, yend = y), 
                   data = line_data,
                   color = "blue", linewidth = 1, linetype = "dashed") +
      # Add label max density
      geom_text(aes(x = max_density_x, y = 0, label = round(max_density_x, 2)), 
                color = "blue", size = 3, vjust = 1.5)
  })
  
  output$densityPlot2 = renderPlot({
    # Filter data based on the selected cluster
    data = house
    if (input$clusterSelection2 != "All") {
      data = data[data$cluster == as.numeric(input$clusterSelection2), ]
    }
    
    # Calculate the density
    density_data = density(data$price, adjust = 4)
    max_density_x = density_data$x[which.max(density_data$y)]
    max_density_y = max(density_data$y)
    # Create a data frame for the vertical line
    line_data = data.frame(x = c(max_density_x, max_density_x), 
                           y = c(0, max_density_y))
    
    # Generate the density plot
    ggplot(data, aes(x = price)) +
      # Normalise the histogram
      geom_histogram(aes(y = after_stat(density)),
                     # Adjust binwidth to the scale of the data
                     binwidth = 50000,
                     color = "black", fill = "lightblue", alpha = 0.7) +
      geom_density(aes(y = after_stat(density)),  
                   # Adjust the color of the density curve
                   color = "red", 
                   # Adjust the size of the density curve
                   linewidth = 1,
                   # Adjust the smoothing parameter for density
                   adjust = 4) + 
      labs(title = paste("Density Plot for Cluster", input$clusterSelection2),
           x = "Price",
           y = "Density") +
      xlim(0, 8000000) +
      # Add vertical line at max density
      geom_segment(aes(x = x, y = 0, xend = x, yend = y), 
                   data = line_data,
                   color = "blue", linewidth = 1, linetype = "dashed") +
      # Add label max density
      geom_text(aes(x = max_density_x, y = 0, label = round(max_density_x, 2)), 
                color = "blue", size = 3, vjust = 1.5)
  })
  
}

# Run the application 
shinyApp(ui, server)
