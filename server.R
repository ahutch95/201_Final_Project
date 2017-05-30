# server.R
library(dplyr)
library(plotly)

# Set working directory

# Read in data


# Start shinyServer
shinyServer(function(input, output) { 
  
  datasetInput <- reactive({
    switch(input$Region,
           "Australasia/Oceania" = data <- read.csv("./data/data.Australasia.Oceania.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8"),
           "Central America" = data <- read.csv("./data/data.Central.America.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8"),
           "Central Asia" = data <- read.csv("./data/data.Central.Asia.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8"),
           "East Asia" = data <- read.csv("./data/data.East.Asia.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8"),
           "Eastern Europe" = data <- read.csv("./data/data.Eastern.Europe.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8"),
           "Middle East/North Africa" = data <- read.csv("./data/data.Middle.East.North.Africa.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8"),
           "North America" = data <- read.csv("./data/data.North.America.csv", stringsAsFactors = FALSE),
           "South America" = data <- read.csv("./data/data.South.America.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8"),
           "South Asia" = data <- read.csv("./data/data.South.Asia.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8"),
           "Southeast Asia" = data <- read.csv("./data/data.Southeast.Asia.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8"),
           "Sub-Saharan Africa" = data <- read.csv("./data/data.Sub.Africa.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8"),
           "Western Europe" = data <- read.csv("./data/data.Western.Europe.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8"))
  })
  
  output$map <- renderPlotly({
    map.data <- datasetInput()
    region <- input$Region
    years <- input$Years
    type <- input$Type
    if (region == 'North America') {
      scope <- 'north america'
    } else if (region == 'Central America' | region == 'South America') {
      scope <- 'south america'
    } else if (region == 'Central Asia' | region == 'South Asia' | region == 'Southeast Asia' | region == 'East Asia' | region == 'Australasia/Oceania') {
      scope <- 'asia'
    } else if (region == 'Western Europe' | region == 'Eastern Europe') {
      scope <- 'europe'
    } else if (region == 'Sub-Saharan Africa' | region == 'Middle East/North Africa') {
      scope <- 'africa'
    } else {
      scope <- 'world'
    }

    g <- list(
      scope = scope,
      showland = TRUE,
      landcolor = toRGB("gray85"),
      subunitwidth = 1,
      countrywidth = 1,
      subunitcolor = toRGB("white"),
      countrycolor = toRGB("white")
    )
    
    plot_ly(map.data, lat = map.data$latitude, lon = map.data$longitude, type = 'scattergeo', mode = 'markers') %>% layout(geo = g)
  })
  
  output$pies <- renderPlotly({
    chart.data <- datasetInput()
    attack.data <- data %>%
      select(attacktype1_txt) %>%
      group_by(attacktype1_txt) %>%
      mutate(count = n()) %>%
      distinct(attacktype1_txt, count)
    
    a <- plot_ly(attack.data, labels = ~attacktype1_txt, values = ~count, type = 'pie', textposition = 'outside',
            textinfo = 'label+percent', insidetextfont = list(color = '#FFFFFF'),
            hoverinfo = 'text',
            text = ~paste(attacktype1_txt, count),
            marker = list(colors = colors,
                          line = list(color = '#FFFFFF', width = 1)),
            #The 'pull' attribute can also be used to create space between the sectors
            showlegend = FALSE) %>%
      layout(title = 'Attack Types breakdown',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    

    target.data <- data %>%
      select(targtype1_txt) %>%
      group_by(targtype1_txt) %>%
      mutate(count = n()) %>%
      distinct(targtype1_txt, count)
    
    t <- plot_ly(target.data, labels = ~targtype1_txt, values = ~count, type = 'pie', textposition = 'outside',
                 textinfo = 'label+percent', insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'text',
                 text = ~paste(targtype1_txt, count),
                 marker = list(colors = colors,
                               line = list(color = '#FFFFFF', width = 1)),
                 #The 'pull' attribute can also be used to create space between the sectors
                 showlegend = FALSE) %>%
      layout(title = 'Target Types breakdown',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    

    weapon.data <- data %>%
      select(weaptype1_txt) %>%
      group_by(weaptype1_txt) %>%
      mutate(count = n()) %>%
      distinct(weaptype1_txt, count)
    
    w <- plot_ly(weapon.data, labels = ~weaptype1_txt, values = ~count, type = 'pie', textposition = 'outside',
                 textinfo = 'label+percent', insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'text',
                 text = ~paste(weaptype1_txt, count),
                 marker = list(colors = colors,
                               line = list(color = '#FFFFFF', width = 1)),
                 #The 'pull' attribute can also be used to create space between the sectors
                 showlegend = FALSE) %>%
      layout(title = 'Weapon Types breakdown',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    category = input$Type
    plot <- t
    if (category == "Attack") {
      plot <- a
    }
    if (category == "Target") {
      plot <- t
    }
    if (category == "Weapon") {
      plot <- w
    }
    plot
  })
  
  
})