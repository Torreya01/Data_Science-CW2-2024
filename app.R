# Load necessary libraries
# Load libraries
library(shiny)
library(leaflet)
library(dplyr)
library(DT)

# Define UI
ui <- navbarPage("House Prices in King County",
                 tabPanel("Map",
                          sidebarLayout(
                            sidebarPanel(
                              sliderInput("priceRange",
                                          "Price Range:",
                                          min = 0,  # Initial minimum value
                                          max = 1,  # Initial maximum value
                                          value = c(0, 1),  # Initial range from min to max
                                          step = 50000,  # Steps in the slider (increments of $50,000)
                                          pre = "$"  # Prefix for values shown in the slider
                              ),
                              checkboxGroupInput("selectedClusters",
                                                 "Select Clusters:",
                                                 choices = NULL
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
                 tabPanel("Density Discussion",
                          p("Below is the histogram of the reduced data with a density curve."),
                          
                          # Add the histogram image here
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
                          where most prices distributed.")),
                          
                 tabPanel("House Clusters",
                          div(style = "text-align: center;",  # Center the image and caption
                              img(src = "figures/Cluster.png", height = "600px", width = "800px"),
                              p("10 different clusters shown on the King County map")),
                          
                          p("The plot is a scatterplot visualizing house data from King County, 
                          categorized into 10 different clusters via k-means. Each cluster 
                          is represented by a unique color."),
    
                          p("Some clusters like 1, 2, 3 and 4 are more densely packed, while others 
                          are more spread out, which might reflect the population density 
                          or the type of housing available in those areas.")),
                          
                 tabPanel("Box-plot Analysis",
                          # Add the box plot image here
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
                          nice streets and ")),
                 tabPanel("Transportation",
                          h3("Nearby Transportations"),
                          p("Details about the transportation..."))
)


# Define server
server = function(input, output, session) {
  
  # Read data from a CSV file
  house = read.csv("data/derived/location_clustered.csv", stringsAsFactors = FALSE)
  
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
  
  # Define a reactive expression to filter data based on the slider input

  # Update reactive expression for filtered data
  filteredData <- reactive({
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
  
}

# Run the application 
shinyApp(ui, server)
