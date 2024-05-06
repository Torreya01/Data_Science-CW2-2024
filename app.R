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
                              Therefore, I reduced the data set into 2006 observations."),
                              
                              p("I splitted the data into 5 ranges: [75000, 1600000),
                              [1600000, 3125000), [3125000, 4650000), [4650000, 6175000),
                              [6175000, 7700000] and the percentages are: 97.92%, 
                              1.946%, 0.1417%, 0.02362% and 0.01388%. I assign 2000 
                              observtions based on the percentages. However, the 
                              percentages for price range [4650000, 7700000] are too 
                              small to choose one observation, I select all observations
                              in these intervals. The total observations would be 2006. 
                              For simplicity, I will look into the reduced data set 
                              instead of the full data set."),
                            )
                          )),
                          
                 tabPanel("Statistical Analysis",
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
                          
                          p("The plot is a scatterplot visualizing house data from King County, 
                          categorized into 10 different clusters via k-means. Each cluster 
                          is represented by a unique color. K-means is a popular clustering algorithm 
                          used in data analysis and machine learning to partition a set of observations 
                          into a specified number of clusters, where each observation belongs 
                          to the cluster with the nearest mean."),
    
                          p("Some clusters like 1, 2, 3 and 4 are more densely packed, while others 
                          are more spread out, which reflects the population density 
                          or the type of housing available in those areas are not that many. Especially for 
                          cluster ."),
                          
                          h3("Density plot of the reduced data with a density curve"),
                         
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
                          In this plot, the mode of the distribution is around 415944.24, 
                          where most prices distributed."),
                          
                          fluidRow(
                            column(6,  # First column for dynamic density plots
                                   h4("Density Plot for Specific Cluster"),
                                   selectInput("clusterSelection1", "Choose a Cluster:",
                                               choices = c("All Clusters", as.character(1:10))),
                                   plotOutput("densityPlot1", width = "100%", height = "400px")),
                            column(6,  # Second column for static image
                                   h4("Full Data Density Plot"),
                                   selectInput("clusterSelection2", "Choose a Cluster:",
                                               choices = c("All Clusters", as.character(1:10))),
                                   plotOutput("densityPlot2", width = "100%", height = "400px"))
                          ),
                          
                          p("Here you can compare the densities between "),
                          
                          h3("The boxplot for 10 different clusters"),
                          
                          div(style = "text-align: center;",  # Center the image and caption
                              img(src = "figures/Box.png", height = "600px", width = "800px"),
                              p("Box plot of the clusters showing differnt variability")
                           ),
                          
                          p("Through the box plot of the data, I can visualize the distribution
                          of house prices across 10 different clusters."),
                          
                          p("Clusters 1, 3 and 4 have a high variability in house prices, 
                          with a wide range and several outliers. The outliers are high 
                          price points, indicating that there are some houses that are 
                          much more expensive than the typical house in the cluster. 
                          Clusters like 5, 6, 7, and 10 seem to have a lower variability, 
                          with narrower boxes and fewer outliers."),
                          
                          p("Natually, it raises the question: what will affect the prices 
                          and why are these houses so expensive?")),
                 
                 tabPanel("Living Environment",
                          p("Environment around the houses can be a great impact of the prices.
                          Houses located in a nice neighbourhood will have higher prices. Below
                          are the street views of the three most expensive houses."),

                          div(style = "text-align: center;",  # Center the image and caption
                              img(src = "figures-from-internet/Street-View-1.png", height = "600px", width = "800px"),
                              p("Street view of the most expensive house")
                          ),
                          div(style = "text-align: center;",  # Center the image and caption
                              img(src = "figures-from-internet/Street-View-2.png", height = "600px", width = "800px"),
                              p("Street view of the second expensive house")
                          ),
                          div(style = "text-align: center;",  # Center the image and caption
                              img(src = "figures-from-internet/Street-View-3.png", height = "600px", width = "800px"),
                              p("Street view of the second expensive house")
                          ),
                          
                          p("Based on these street views, we can say they all have great sunshine,
                          nice streets and "),
                          
                          p("The ")),
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
    if (input$clusterSelection1 != "All Clusters") {
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
      geom_density(aes(y = ..density..),  
               # Adjust the color of the density curve
               color = "red", 
               # Adjust the size of the density curve
               linewidth = 1,
               # Adjust the smoothing parameter for density
               adjust = 4) + 
      labs(title = paste("Density Plot for Cluster", input$clusterSelection),
           x = "Price",
           y = "Density") +
      xlim(0, 8000000) +
      # Add vertical line at max density
      geom_segment(aes(x = x, y = 0, xend = x, yend = y), 
                   data = line_data,
                   color = "blue", size = 1, linetype = "dashed") +
      # Add label max density
      geom_text(aes(x = max_density_x, y = 0, label = round(max_density_x, 2)), 
                color = "blue", size = 3, vjust = 1.5)
  })
  
  output$densityPlot2 = renderPlot({
    # Filter data based on the selected cluster
    data = house
    if (input$clusterSelection2 != "All Clusters") {
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
      geom_density(aes(y = ..density..),  
                   # Adjust the color of the density curve
                   color = "red", 
                   # Adjust the size of the density curve
                   linewidth = 1,
                   # Adjust the smoothing parameter for density
                   adjust = 4) + 
      labs(title = paste("Density Plot for Cluster", input$clusterSelection),
           x = "Price",
           y = "Density") +
      xlim(0, 8000000) +
      # Add vertical line at max density
      geom_segment(aes(x = x, y = 0, xend = x, yend = y), 
                   data = line_data,
                   color = "blue", size = 1, linetype = "dashed") +
      # Add label max density
      geom_text(aes(x = max_density_x, y = 0, label = round(max_density_x, 2)), 
                color = "blue", size = 3, vjust = 1.5)
  })
  
}

# Run the application 
shinyApp(ui, server)
