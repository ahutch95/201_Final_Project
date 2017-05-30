library(plotly)
library(dplyr)

# takes in a data set, years selected
# if a range of years is selected, returns a scatterplot of total incidents per year
# if a single year is selected, returns a scatterplot of impact (deaths/injuries) for each incident 
BuildTimeSeries <- function(data, region, year1, year2) {
  
  # filter data by region
  if(region == "Australasia/Oceania") {
    data <- data %>% filter(region == '12')
  } else if (region == "Central America") {
    data <- data %>% filter(region == 2)
  } else if (region == "Central Asia") {
    data <- data %>% filter(region == 7)
  } else if (region == "East Asia") {
    data <- data %>% filter(region == 4)
  } else if (region == "Eastern Europe") {
    data <- data %>% filter(region == 9)
  } else if (region == "Middle East/North America") {
    data <- data %>% filter(region == 10)
  } else if (region == "North America") {
    data <- data %>% filter(region == 1)
  } else if (region == "South America") {
    data <- data %>% filter(region == 3)
  } else if (region == "South Asia") {
    data <- data %>% filter(region == 6)
  } else if (region == "Southeast Asia") {
    data <- data %>% filter(region == 5)
  } else if (region == "Sub-Saharan Africa") {
    data <- data %>% filter(region == 11)
  } else if (region == "Western Europe") {
    data <- data %>% filter(region == 8)
  }

  # plot total number of attacks each year
  if (year1 != year2) {
    prepped.data <- data %>% 
      filter(imonth != 0, iday != 0, iyear >= year1, iyear <= year2) %>%
      group_by(iyear) %>% 
      summarize(nattacks = n())   
    
    plot <- plot_ly(data=prepped.data, type = 'scatter',
                      x = ~iyear,
                      y = ~nattacks,
                      mode='markers',
                      marker = list(
                        opacity = .4,
                        size = 10
                      )) %>%
      layout(title = 'Attacks Per Year',
            xaxis = list(title = 'Year'),
            yaxis = list(title = 'Total Attacks')
      )
  } 
  
  # plot total number of people killed/injured for each incident
  else {
    prepped.data <- data %>% 
      filter(imonth != 0, iday != 0, iyear == year1) %>%
      mutate(date = paste0(imonth, '/', iday, '/', iyear), 
             impact = nkill + nwound)
    
    plot <- plot_ly(data=prepped.data, type = 'scatter',
                    x = ~date,
                    y = ~impact,
                    mode='markers',
                    marker = list(
                      opacity = .4,
                      size = 10
                    ),
                    hoverinfo = 'text',
                    text = ~summary) %>%
      layout(title = 'Attack Impact (Combined Deaths and Injuries)',
             xaxis = list(title = 'Date'),
             yaxis = list(title = 'Impact')
      )
  }
  
  return(plot)
}
