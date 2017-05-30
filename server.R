# server.R
library(dplyr)

# Set working directory

# Read in data


# Start shinyServer
shinyServer(function(input, output) { 
  
  datasetInput <- reactive({
    switch(input$Region,
           "Australasia/Oceania" = data <- read.csv("./data/data.Australasia.Oceania.csv", stringsAsFactors = FALSE),
           "Central America" = data <- read.csv("./data/data.Central.America.csv", stringsAsFactors = FALSE),
           "Central Asia" = data <- read.csv("./data/data.Central.Asia.csv", stringsAsFactors = FALSE),
           "East Asia" = data <- read.csv("./data/data.East.Asia.csv", stringsAsFactors = FALSE),
           "Eastern Europe" = data <- read.csv("./data/data.Eastern.Europe.csv", stringsAsFactors = FALSE),
           "Middle East/North Africa" = data <- read.csv("./data/data.Middle.East.North.Africa.csv", stringsAsFactors = FALSE),
           "North America" = data <- read.csv("./data/data.North.America.csv", stringsAsFactors = FALSE),
           "South America" = data <- read.csv("./data/data.South.America.csv", stringsAsFactors = FALSE),
           "South Asia" = data <- read.csv("./data/data.South.Asia.csv", stringsAsFactors = FALSE),
           "Southeast Asia" = data <- read.csv("./data/data.Southeast.Asia.csv", stringsAsFactors = FALSE),
           "Sub-Saharan Africa" = data <- read.csv("./data/data.Sub.Africa.csv", stringsAsFactors = FALSE),
           "Western Europe" = data <- read.csv("./data/data.Western.Europe.csv", stringsAsFactors = FALSE))
  })
  
  output$map <- renderPlotly({
    map.data <- datasetInput()
    region <- input$Region
    years <- input$Years
    type <- input$Type
    # if (region == 'North America') {
    #   scope <- 'north america'
    # } else if (region == 'Central America' | region == 'South America') {
    #   scope <- 'south america'
    # } else if (region == 'Central Asia' | region == 'South Asia' | region == 'Southeast Asia' | region == 'East Asia' | region == 'Australasia/Oceania') {
    #   scope <- 'asia'
    # } else if (region == 'Western Europe' | region == 'Eastern Europe') {
    #   scope <- 'europe'
    # } else if (region == 'Sub-Saharan Africa' | region == 'Middle East/North Africa') {
    #   scope <- 'africa'
    # }
    # 
    # g <- list(
    #   scope = scope,
    #   showland = TRUE,
    #   landcolor = toRGB("gray85"),
    #   subunitwidth = 1,
    #   countrywidth = 1,
    #   subunitcolor = toRGB("white"),
    #   countrycolor = toRGB("white")
    # )
    
    plot_ly(map.data, lat = map.data$latitude, lon = map.data$longitude, type = 'scattergeo', mode = 'markers')
  })
  
})