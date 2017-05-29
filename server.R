# server.R
library(dplyr)

# Set working directory

# Read in data


# Start shinyServer
shinyServer(function(input, output) { 
  output$map <- renderPlot({input$Region; input$Years; input$Type})
  
})