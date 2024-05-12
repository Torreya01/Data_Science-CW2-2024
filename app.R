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
source("source/helper-functions/data-filter.R")

# Define UI
ui = navbarPage("House Prices in King County",
                theme = bs_theme(version = 5, bootswatch = "minty"),
                
                # Code for the map tab
                tabPanel("Map",
                         
                         # Add adjustments to adjust inputs
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
                             plotOutput("mapdensity")),
                           
                           # Add elements to the main panel
                            mainPanel(
                              h3("Houses on the map of King County"),
                              
                              uiOutput("MapPart1"),
                              
                              leafletOutput("map"),
                              
                              tags$h4(style = "color: red;", "Warning:"),
                              
                              uiOutput("MapPart2"),))),
                
                # Code for the density tab
                tabPanel("Density plot",
                         
                         # Add elements to the main panel
                         uiOutput("DensityPart1"),
                         
                         fluidRow(
                           column(6,  
                                  h4("Density plot for cluster choosing below"),
                                  fluidRow(
                                    column(6, selectInput("clusterSelection1", "Choose a Cluster:", choices = c("All", as.character(1:10)))),
                                    column(6, selectInput("yearSelect1", "Select Year:", choices = c("2014", "2015")))),
                                  plotOutput("densityPlot1", width = "100%", height = "400px")),
                           column(6,
                                  h4("Density plot for cluster choosing below"),
                                  fluidRow(
                                    column(6, selectInput("clusterSelection2", "Choose a Cluster:", choices = c("All", as.character(1:10)))),
                                    column(6, selectInput("yearSelect2", "Select Year:", choices = c("2014", "2015")))),
                                  plotOutput("densityPlot2", width = "100%", height = "400px"))),
                         
                         uiOutput("DensityPart2")),
                  
                # Code for the box tab        
                tabPanel("Box plot",
                         
                         # Add elements to the main panel
                         fluidRow(
                           column(12, 
                                  selectInput("yearInput", 
                                              "Select Year:", 
                                              choices = c(2014, 2015),
                                              selected = 2014))),
                         fluidRow(
                           column(12,
                                  plotOutput("boxplot", width = "100%"))),
                         
                         uiOutput("Box")),
                 
                # Code for the box tab
                 tabPanel("Living Environment",
                          
                          uiOutput("EnvironmentPart1"),
                          
                          h3("Street views of the houses"),
                          
                          fluidRow(
                            column(4,
                              div(style = "text-align: center;",  # Center the image and caption
                                       img(src = "Street-View-1.png", height = "100%", width = "100%"),
                                       p("Street view of the most expensive house in cluster 4"))),
                            column(4,
                                   div(style = "text-align: center;",  # Center the image and caption
                                       img(src = "Street-View-2.png", height = "100%", width = "100%"),
                                       p("Street view of the most expensive house in cluster 5"))),
                            column(4,
                                   div(style = "text-align: center;",  # Center the image and caption
                                       img(src = "Street-View-3.png", height = "100%", width = "100%"),
                                       p("Street view of the most expensive house in cluster 6")))
                          ),
                          
                          uiOutput("EnvironmentPart2"),
                          
                          h3("Water views of the houses"),
                          
                          fluidRow(
                            column(4,
                                   div(style = "text-align: center;",  # Center the image and caption
                                       img(src = "Water-View-1.png", height = "100%", width = "100%"),
                                       p("Water view of Lake Union"))),
                            column(4,
                                   div(style = "text-align: center;",  # Center the image and caption
                                       img(src = "Water-View-2.png", height = "100%", width = "100%"),
                                       p("Water view of Lake Washington"))),
                            column(4,
                                   div(style = "text-align: center;",  # Center the image and caption
                                       img(src = "Water-View-3.png", height = "100%", width = "100%"),
                                       p("Water view of Lake Washington")))
                          ),
                          
                          uiOutput("EnvironmentPart3")))

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
    filterData(house, input$priceRange, input$selectedClusters, input$yearSelect, colour_map)
  })
  
##################################### Code for things in map tab ##########################################
  # Read the map tab Markdown file
  MapContent = readLines("text/map-text.md")
  
  # Split the content for map tab at the marker
  MapSplitIndex = which(MapContent == "<!-- split here -->")
  MapPart1 = MapContent[1:(MapSplitIndex - 1)]
  MapPart2 = MapContent[(MapSplitIndex + 1):length(MapContent)]
  
  # Convert markdown to HTML and render for map tab
  output$MapPart1 = renderUI({
    HTML(markdown::markdownToHTML(text = paste(MapPart1, collapse = "\n"), fragment.only = TRUE))
  })
  
  output$MapPart2 = renderUI({
    HTML(markdown::markdownToHTML(text = paste(MapPart2, collapse = "\n"), fragment.only = TRUE))
  })
  
  # Render the map output
  output$map = renderLeaflet({
    mapproduce(filteredData())
  })
  
  # Render the map desity plot
  output$mapdensity = renderPlot({
    densityplot(filteredData())
  })
  
##################################### Code for things in density tab ######################################
  # Read the density tab Markdown file
  DensityContent = readLines("text/density-text.md")
  
  # Split the content for map tab at the marker
  DensitySplitIndex = which(DensityContent == "<!-- split here -->")
  DensityPart1 = DensityContent[1:(DensitySplitIndex - 1)]
  DensityPart2 = DensityContent[(DensitySplitIndex + 1):length(DensityContent)]
  
  # Convert markdown to HTML and render for map tab
  output$DensityPart1 = renderUI({
    HTML(markdown::markdownToHTML(text = paste(DensityPart1, collapse = "\n"), fragment.only = TRUE))
  })
  
  output$DensityPart2 = renderUI({
    HTML(markdown::markdownToHTML(text = paste(DensityPart2, collapse = "\n"), fragment.only = TRUE))
  })
  
  # Render the comparison density plot
  output$densityPlot1 = renderPlot({
    data = house[house$date == input$yearSelect1, ]
    if (input$clusterSelection1 != "All") {
      data = data[data$cluster == as.numeric(input$clusterSelection1), ]
    }
    densityplot(data, input$clusterSelection1)
  })
  
  # Render the comparison density plot
  output$densityPlot2 = renderPlot({
    data = house[house$date == input$yearSelect2, ]
    if (input$clusterSelection2 != "All") {
      data = data[data$cluster == as.numeric(input$clusterSelection2), ]
    }
    densityplot(data, input$clusterSelection2)
  })
  
##################################### Code for things in box tab ##########################################
  # Read the box-plot tab Markdown file
  BoxContent = readLines("text/box-text.md")
  
  # Convert markdown to HTML and render for box tab
  output$Box = renderUI({
    HTML(markdown::markdownToHTML(text = paste(BoxContent, collapse = "\n"), fragment.only = TRUE))
  })
  
  # Render the box plot
  output$boxplot = renderPlot({
    data = house
    data = data[data$date == as.numeric(input$yearInput), ]
    boxplot(data, input$yearInput)
  })
  
##################################### Code for things in environment tab #######################################  
  # Read the environment tab Markdown file
  EnvironmentContent = readLines("text/environment-text.md")
  
  # Split the content for enviroment tab at the marker
  EnvironmentSplitIndices = which(EnvironmentContent == "<!-- split here -->")
  EnvironmentPart1 = EnvironmentContent[1:(EnvironmentSplitIndices[1] - 1)]
  EnvironmentPart2 = EnvironmentContent[(EnvironmentSplitIndices[1] + 1):(EnvironmentSplitIndices[2] - 1)]
  EnvironmentPart3 = EnvironmentContent[(EnvironmentSplitIndices[2] + 1):length(EnvironmentContent)]
  
  # Convert markdown to HTML and render for environment tab
  output$EnvironmentPart1 = renderUI({
    HTML(markdown::markdownToHTML(text = paste(EnvironmentPart1, collapse = "\n"), fragment.only = TRUE))
  })
  
  output$EnvironmentPart2 = renderUI({
    HTML(markdown::markdownToHTML(text = paste(EnvironmentPart2, collapse = "\n"), fragment.only = TRUE))
  })
  
  output$EnvironmentPart3 = renderUI({
    HTML(markdown::markdownToHTML(text = paste(EnvironmentPart3, collapse = "\n"), fragment.only = TRUE))
  })
  
  
  }

# Run the application 
shinyApp(ui, server)
