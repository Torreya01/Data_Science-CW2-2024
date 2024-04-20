# Load necessary libraries
library(shiny)
library(leaflet)
library(dplyr)
library(DT)

# Define UI
ui = fluidPage(
  titlePanel("House Prices in King County"),  # Title of the app
  sidebarLayout(
    sidebarPanel(
      # Slider input for selecting price range
      sliderInput("priceRange",
                  "Price Range:",
                  min = 0,  # Initial minimum value
                  max = 1,  # Initial maximum value
                  value = c(0, 1),  # Initial range from min to max
                  step = 50000,  # Steps in the slider (increments of $50,000)
                  pre = "$"  # Prefix for values shown in the slider
      ),
      # Inside sidebarPanel:
      
      # ... (existing sliderInput)
      
      # New input for selecting clusters
      checkboxGroupInput("selectedClusters",
                         "Select Clusters:",
                         choices = NULL
      )
    ),
    mainPanel(
      leafletOutput("map"),  # Placeholder for the leaflet map
      # Header for warning
      h4("Waring:"),
      p("Due to the large data set, the application may be hard to run, please be
        patient when the application is running."),
      
      # Header for description section
      h3("Project Description"),
      
      # Header for Data Selection
      h4("Data selection"),
      p("The minimum of the data set is 75000 and the maximum is 7700000. Since 
        the full data set has 21613 observations, which is too big for the application 
        to operate. Therefore, I reduced the data set into 2006 observations."),
      
      p("I splitted the data into 5 ranges: [75000, 1600000), [1600000, 3125000), 
        [3125000, 4650000), [4650000, 6175000), [6175000, 7700000] and the percentages
        are shown here: 97.92%, 1.946%, 0.1417%, 0.02362% and 0.01388%. I assign 
        2000 observtions based on the percentages. However, the percentages for price
        range [4650000, 7700000] are too small, I select all observations in these ranges.
        The total observations would be 2006. For simplicity, I will look into the 
        reduced data set instead of the full data set."),
      
      p("")
    )
  )
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
  # Inside server function:
  
  # ... (existing observe function)
  
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
      setView(lng = -121.9836, lat = 47.5480, zoom = 10) %>%
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
