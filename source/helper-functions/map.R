# Load library
library(leaflet)

# # Define map function
mapproduce = function(data) {
  # Define the bounds for King County to restrict the map view
  bounds = list(
    southWest = list(lat = 47.2, lng = -122.5),
    northEast = list(lat = 47.9, lng = -121.5)
  )
  
  # Create the map with initial view settings
  map = leaflet(data) %>%
    # Add default OpenStreetMap tiles
    addTiles() %>%
    setView(lng = -121.9836, lat = 47.5480, zoom = 9) %>%
    setMaxBounds(lng1 = bounds$southWest$lng, lat1 = bounds$southWest$lat,
                 lng2 = bounds$northEast$lng, lat2 = bounds$northEast$lat)
  
  # Add markers to the map if data is available
  if (nrow(data) > 0) {
    map <- map %>% addCircleMarkers(
      ~long, ~lat, 
      popup = ~paste("Price: $", price, "<br>Cluster: ", cluster),
      color = "black",      # Black outline
      fillColor = ~color,   # Fill color mapped to cluster
      fillOpacity = 1,      # Fully opaque fill
      opacity = 1,          # Fully opaque outline
      radius = 3,           # Smaller radius for smaller dots
      weight = 1            # Outline thickness
    )
  }
  # Return the map object
  return(map)
}
