# server.R
library(dplyr)
library(plotly)

# Set working directory

# File for creating time scatterplot
source(file = './BuildTimeSeries.R')

# Start shinyServer
shinyServer(function(input, output) { 
  
  #read in data
  aus <- read.csv("./data/data.Australasia.Oceania.csv", stringsAsFactors = FALSE, fileEncoding = "latin1")
  central.america <- read.csv("./data/data.Central.America.csv", stringsAsFactors = FALSE, fileEncoding = "latin1")
  central.asia <- read.csv("./data/data.Central.Asia.csv", stringsAsFactors = FALSE, fileEncoding = "latin1")
  east.asia <- read.csv("./data/data.East.Asia.csv", stringsAsFactors = FALSE, fileEncoding = "latin1")
  east.europe <- read.csv("./data/data.Eastern.Europe.csv", stringsAsFactors = FALSE, fileEncoding = "latin1")
  middle.east <- read.csv("./data/data.Middle.East.North.Africa.csv", stringsAsFactors = FALSE, fileEncoding = "latin1")
  north.america <- read.csv("./data/data.North.America.csv", stringsAsFactors = FALSE, fileEncoding = "latin1")
  south.america <- read.csv("./data/data.South.America.csv", stringsAsFactors = FALSE, fileEncoding = "latin1")
  south.asia <- read.csv("./data/data.South.Asia.csv", stringsAsFactors = FALSE, fileEncoding = "latin1")
  southeast.asia <- read.csv("./data/data.Southeast.Asia.csv", stringsAsFactors = FALSE, fileEncoding = "latin1")
  africa <- read.csv("./data/data.Sub.Africa.csv", stringsAsFactors = FALSE, fileEncoding = "latin1")
  western.europe <- data <- read.csv("./data/data.Western.Europe.csv", stringsAsFactors = FALSE, fileEncoding = "latin1")
  
  filteredByTarget <- function(data, target.type){
    if (target.type == 'All') {
      return(data)
    } else {
      filtered.data <- filter(data, targtype1_txt == target.type)
      return(filtered.data)
    }
  }
    
  filteredByAttack <- function(data, attack.type){
    if (attack.type == 'All') {
      return(data)
    } else {
      filtered.data <- filter(data, attacktype1_txt == attack.type)
      return(filtered.data)
    }
  }
    
  filteredByWeapon <- function(data, weapon.type){
    if (weapon.type == 'All') {
      return(data)
    } else {
      filtered.data <- filter(data, weaptype1_txt == weapon.type)
      return(filtered.data)
    }
  }
  
  datasetInput <- reactive({
    attack.type <- input$AttackTypeMap
    target.type <- input$TargetTypeMap
    weapon.type <- input$WeaponTypeMap
    switch(input$RegionMap,
             "All" = data <- rbind(aus, central.america, central.asia, east.asia, east.europe, middle.east, 
                                   north.america, south.america, south.asia, southeast.asia, africa, western.europe) %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
             "Australasia/Oceania" = data <- aus %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
             "Central America" = data <- central.america %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
             "Central Asia" = data <- central.asia %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
             "East Asia" = data <- east.asia %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
             "Eastern Europe" = data <- east.europe %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
             "Middle East/North Africa" = data <- middle.east %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
             "North America" = data <- north.america %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
             "South America" = data <- south.america %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
             "South Asia" = data <- south.asia %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
             "Southeast Asia" = data <- southeast.asia %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
             "Sub-Saharan Africa" = data <- africa %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]),
             "Western Europe" = data <- western.europe %>% filter(iyear >= input$YearsMap[1] & iyear <= input$YearsMap[2]))
    data.filtered.by.target <- filteredByTarget(data, target.type)
    data.filtered.by.target.and.attack <- filteredByAttack(data.filtered.by.target, attack.type)
    data.filtered.by.target.and.attack.and.weapon <- filteredByWeapon(data.filtered.by.target.and.attack, weapon.type)
    return(data.filtered.by.target.and.attack.and.weapon)
    })
  
  #for regions that aren't included in default plotly scopes
  getLatAndLong <- reactive({
    switch(input$RegionMap,
           "Australasia/Oceania" = coords <- data.frame("lon.min" = c(90), "lon.max" = c(180), "lat.min" = c(-60), "lat.max" = c(15)),
           "Central America" = coords <- data.frame("lon.min" = c(-120), "lon.max" = c(-45), "lat.min" = c(0), "lat.max" = c(45)),
           "Eastern Europe" = coords <- data.frame("lon.min" = c(0), "lon.max" = c(90), "lat.min" = c(0), "lat.max" = c(75)),
           "Middle East/North Africa" = coords <- data.frame("lon.min" = c(-15), "lon.max" = c(75), "lat.min" = c(0), "lat.max" = c(75)),
           "East Asia" = coords <- data.frame("lon.min" = c(60), "lon.max" = c(150), "lat.min" = c(0), "lat.max" = c(60)),
           "Central Asia" = coords <- data.frame("lon.min" = c(15), "lon.max" = c(105), "lat.min" = c(0), "lat.max" = c(90)),
           "South Asia" = coords <- data.frame("lon.min" = c(45), "lon.max" = c(105), "lat.min" = c(0), "lat.max" = c(45)),
           "Southeast Asia" = coords <- data.frame("lon.min" = c(75), "lon.max" = c(150), "lat.min" = c(-15), "lat.max" = c(45)),
           "North America" = coords <- data.frame("lon.min" = c(-135), "lon.max" = c(-45), "lat.min" = c(0), "lat.max" = c(75)),
           "South America" = coords <- data.frame("lon.min" = c(-90), "lon.max" = c(-30), "lat.min" = c(-60), "lat.max" = c(15)),
           "Western Europe" = coords <- data.frame("lon.min" = c(-30), "lon.max" = c(60), "lat.min" = c(15), "lat.max" = c(75)),
           "Sub-Saharan Africa" = coords <- data.frame("lon.min" = c(-30), "lon.max" = c(60), "lat.min" = c(-45), "lat.max" = c(45)))
  })
  
  getPieData <- reactive({
    switch(input$RegionPie,
           "All" = type.data <- rbind(aus, central.america, central.asia, east.asia, east.europe, middle.east, 
                                 north.america, south.america, south.asia, southeast.asia, africa, western.europe) %>% filter(iyear >= input$YearsPie[1] & iyear <= input$YearsPie[2]),
           "Australasia/Oceania" = type.data <- aus %>% filter(iyear >= input$YearsPie[1] & iyear <= input$YearsPie[2]),
           "Central America" = type.data <- central.america %>% filter(iyear >= input$YearsPie[1] & iyear <= input$YearsPie[2]),
           "Central Asia" = type.data <- central.asia %>% filter(iyear >= input$YearsPie[1] & iyear <= input$YearsPie[2]),
           "East Asia" = type.data <- east.asia %>% filter(iyear >= input$YearsPie[1] & iyear <= input$YearsPie[2]),
           "Eastern Europe" = type.data <- east.europe %>% filter(iyear >= input$YearsPie[1] & iyear <= input$YearsPie[2]),
           "Middle East/North Africa" = type.data <- middle.east %>% filter(iyear >= input$YearsPie[1] & iyear <= input$YearsPie[2]),
           "North America" = type.data <- north.america %>% filter(iyear >= input$YearsPie[1] & iyear <= input$YearsPie[2]),
           "South America" = type.data <- south.america %>% filter(iyear >= input$YearsPie[1] & iyear <= input$YearsPie[2]),
           "South Asia" = type.data <- south.asia %>% filter(iyear >= input$YearsPie[1] & iyear <= input$YearsPie[2]),
           "Southeast Asia" = type.data <- southeast.asia %>% filter(iyear >= input$YearsPie[1] & iyear <= input$YearsPie[2]),
           "Sub-Saharan Africa" = type.data <- africa %>% filter(iyear >= input$YearsPie[1] & iyear <= input$YearsPie[2]),
           "Western Europe" = type.data <- western.europe %>% filter(iyear >= input$YearsPie[1] & iyear <= input$YearsPie[2]))
    switch(input$TypePie,
           "Target Type" = type.data <- filteredByTarget(data, "All"),
           "Attack Type" = type.data <- filteredByAttack(data, "All"),
           "Weapon Type" = type.data <- filteredByWeapon(data, "All"))
    return(type.data)
    
  })
  
  output$map <- renderPlotly({
    map.data <- datasetInput()
    region <- input$RegionMap
    years <- input$YearsMap
    type <- input$TypeMap
    coords <- getLatAndLong()
    g <- list(
      lonaxis = list(range = c(coords$lon.min, coords$lon.max)),
      lataxis = list(range = c(coords$lat.min, coords$lat.max)),
      showland = TRUE,
      showcountries = TRUE,
      landcolor = "rgb(212, 212, 212)",
      #landcolor = toRGB("white"),
      subunitwidth = 1,
      countrywidth = 1,
      subunitcolor = toRGB("white"),
      countrycolor = toRGB("white")
    )
    req(nrow(map.data) > 0)
    plot_ly(
      map.data,
      lat = map.data$latitude,
      lon = map.data$longitude,
      type = 'scattergeo',
      mode = 'markers',
      color = ~ nkill,
      marker = list(
        opacity = 0.5,
        size = 15,
        colorbar = list(title = "Number Killed")
      ),
      colors = 'Paired',
      text = paste0(
        map.data$city,
        ", ",
        map.data$provstate,
        ", ",
        map.data$country_txt,
        "<br />Number of Deaths: ",
        map.data$nkill,
        "<br />Number of Injuries: ",
        map.data$nwound
      ),
      hoverinfo = "text"
    ) %>% layout(geo = g)
  })
  
  
  #Builds three plots at once for each breakdown, which makes it faster to switch between some pies
  output$pies <- renderPlotly({
    
    region <- input$RegionPie
    years <- input$YearsPie
    type <- input$TypePie
    chart.data <- getPieData()
    
    #Attempt to set margins on pie plot so that text doesnt get cut off
    margin.list <- list(
      l = 50,
      r = 50,
      b = 550,
      t = 50,
      pad = 4
    )
    
    
    #Group data by attack type and get count
    attack.data <- chart.data %>%
      select(attacktype1_txt) %>%
      group_by(attacktype1_txt) %>%
      mutate(count = n()) %>%
      distinct(attacktype1_txt, count)
    
    a <- plot_ly(attack.data, labels = ~attacktype1_txt, values = ~count, type = 'pie', textposition = 'outside',
            textinfo = 'text', insidetextfont = list(color = '#FFFFFF'),
            hoverinfo = 'percent',
            text = ~paste(attacktype1_txt, 'Count:', count),
            marker = list(colors = colors,
            line = list(color = '#FFFFFF', width = 1)),
            showlegend = FALSE) %>%
      layout(title = 'Attack Types Breakdown',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             margin = margin.list
      )
    
    #Group data by target type and get count
    target.data <- chart.data %>%
      select(targtype1_txt) %>%
      group_by(targtype1_txt) %>%
      mutate(count = n()) %>%
      distinct(targtype1_txt, count)
    
    t <-plot_ly(target.data, labels = ~targtype1_txt, values = ~count, type = 'pie', textposition = 'outside',
                 textinfo = 'text', insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'percent',
                 text = ~paste(targtype1_txt, 'Count:', count),
                 marker = list(colors = colors,
                 line = list(color = '#FFFFFF', width = 1)),
                 showlegend = FALSE) %>%
      layout(title = 'Target Types Breakdown',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             margin = margin.list
      ) #changing the margin doesnt seem to be doing anything useful, but it should...
    
    #Group data by weapon type and get count
    weapon.data <- chart.data %>%
      select(weaptype1_txt) %>%
      group_by(weaptype1_txt) %>%
      mutate(count = n()) %>%
      distinct(weaptype1_txt, count)
    
    w <- plot_ly(weapon.data, labels = ~weaptype1_txt, values = ~count, type = 'pie', textposition = 'outside',
                 textinfo = 'text', insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'percent',
                 text = ~paste(weaptype1_txt, 'Count:', count),
                 marker = list(colors = colors,
                line = list(color = '#FFFFFF', width = 1)),
                 showlegend = FALSE) %>%
      layout(title = 'Weapon Types Breakdown',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             margin = margin.list
      )
    
    #Determines which pie is displayed
    category = input$TypePie
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
  # output$text <- renderText({
  #   target.type <- input$TargetTypeMap
  #   target.type
  # })
  
  # code for rendering time series
  
  # get dataset based on region
  datasetInputTime <- reactive({
    switch(input$RegionTime,
           "All" = data <- rbind(aus, central.america, central.asia, east.asia, east.europe, middle.east,
                                 north.america, south.america, south.asia, southeast.asia, africa, western.europe),
           "Australasia/Oceania" = data <- aus,
           "Central America" = data <- central.america,
           "Central Asia" = data <- central.asia,
           "East Asia" = data <- east.asia,
           "Eastern Europe" = data <- east.europe,
           "Middle East/North Africa" = data <- middle.east,
           "North America" = data <- north.america,
           "South America" = data <- south.america,
           "South Asia" = data <- south.asia,
           "Southeast Asia" = data <- southeast.asia,
           "Sub-Saharan Africa" = data <- africa,
           "Western Europe" = data <- western.europe)
  })
  
  # create scatterplot using external function
  output$time <- renderPlotly({
    return(BuildTimeSeries(datasetInputTime(), input$RegionTime, input$YearsTime[1], input$YearsTime[2], input$TargetTypeTime, input$AttackTypeTime, input$WeaponTypeTime))
  })
  
})