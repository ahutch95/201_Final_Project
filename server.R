# server.R
library(dplyr)
library(plotly)

# Set working directory

# Read in data


# Start shinyServer
shinyServer(function(input, output) { 
  
  datasetInput <- reactive({
    years <- input$Years
    switch(input$RegionMap,
           "Australasia/Oceania" = data <- read.csv("./data/data.Australasia.Oceania.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8") %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
           "Central America" = data <- read.csv("./data/data.Central.America.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8") %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
           "Central Asia" = data <- read.csv("./data/data.Central.Asia.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8") %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
           "East Asia" = data <- read.csv("./data/data.East.Asia.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8") %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
           "Eastern Europe" = data <- read.csv("./data/data.Eastern.Europe.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8") %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
           "Middle East/North Africa" = data <- read.csv("./data/data.Middle.East.North.Africa.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8") %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
           "North America" = data <- read.csv("./data/data.North.America.csv", stringsAsFactors = FALSE) %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
           "South America" = data <- read.csv("./data/data.South.America.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8") %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
           "South Asia" = data <- read.csv("./data/data.South.Asia.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8") %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
           "Southeast Asia" = data <- read.csv("./data/data.Southeast.Asia.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8") %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
           "Sub-Saharan Africa" = data <- read.csv("./data/data.Sub.Africa.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8") %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
           "Western Europe" = data <- read.csv("./data/data.Western.Europe.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8") %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]))
  })
  
  #for regions that aren't included in default plotly scopes
  getLatAndLong <- reactive({
    switch(input$RegionMap,
           "Australasia/Oceania" = coords <- data.frame("lon.min" = c(90), "lon.max" = c(180), "lat.min" = c(-60), "lat.max" = c(15)),
           "Central America" = coords <- data.frame("lon.min" = c(-120), "lon.max" = c(-60), "lat.min" = c(0), "lat.max" = c(45)),
           "Eastern Europe" = coords <- data.frame("lon.min" = c(0), "lon.max" = c(90), "lat.min" = c(30), "lat.max" = c(75)),
           "Middle East/North Africa" = coords <- data.frame("lon.min" = c(-15), "lon.max" = c(75), "lat.min" = c(0), "lat.max" = c(75)))
  })
  
  output$map <- renderPlotly({
    map.data <- datasetInput()
    region <- input$RegionMap
    years <- input$YearsMap
    type <- input$TypeMap
    if (region == 'North America') {
      scope <- 'north america'
    } else if (region == 'South America') {
      scope <- 'south america'
    } else if (region == 'Central Asia' | region == 'South Asia' | region == 'Southeast Asia' | region == 'East Asia') {
      scope <- 'asia'
    } else if (region == 'Western Europe') {
      scope <- 'europe'
    } else if (region == 'Sub-Saharan Africa') {
      scope <- 'africa'
    } else {
      scope <- 'world'
    }
    if (region == 'Australasia/Oceania' | region == 'Central America' | region == 'Eastern Europe' | region == 'Middle East/North Africa') {
      coords <- getLatAndLong()
      g <- list(
        lonaxis = list(
          range = c(coords$lon.min, coords$lon.max)),
        lataxis = list(
          range = c(coords$lat.min, coords$lat.max)),
        showland = TRUE,
        landcolor = toRGB("gray85"),
        subunitwidth = 1,
        countrywidth = 1,
        subunitcolor = toRGB("white"),
        countrycolor = toRGB("white")
      )
    } else {
      g <- list(
        scope = scope,
        showland = TRUE,
        landcolor = toRGB("gray85"),
        subunitwidth = 1,
        countrywidth = 1,
        subunitcolor = toRGB("white"),
        countrycolor = toRGB("white")
      )
    }
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
  
  
  #code for checking the number of rows in the filtered data
  output$text <- renderText({
    coords <- getLatAndLong()
    coords$lon.min
    coords$lon.max
    coords$lat.min
    coords$lat.max
  })
  
})