library(plotly)
library(dplyr)

# takes in a data set, years selected
# if a range of years is selected, returns a scatterplot of total incidents per year
# if a single year is selected, returns a scatterplot of impact (deaths/injuries) for each incident 
BuildTimeSeries <- function(data, region, year1, year2, target.type, attack.type, weapon.type) {
  # filter based on target type selection
  if (target.type != 'All') {
    data <- data %>% filter(targtype1_txt == target.type)
  }
  # filter based on attack type selection
  if (attack.type != 'All') {
    data <- data %>% filter(attacktype1_txt == attack.type)
  }
  # filter based on weapon type selection
  if (weapon.type != 'All') {
    data <- data %>% filter(weaptype1_txt == weapon.type)
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
      layout(title = 'Total Instances of Terrorist Activitiy Per Year',
            xaxis = list(title = 'Year'),
            yaxis = list(title = 'Total Instances')
      )
  } 
  
  # plot total number of people killed/injured for each incident
  else {
    prepped.data <- data %>% 
      filter(imonth != 0, iday != 0, iyear == year1) %>%
      mutate(date = paste0(imonth, '/', iday, '/', iyear), 
             impact = nkill + nwound)
    
    plot <- plot_ly(source = "source",
                    data=prepped.data, type = 'scatter',
                    x = ~date,
                    y = ~impact,
                    mode='markers',
                    marker = list(
                      opacity = .4,
                      size = 10
                    ),
                    hoverinfo = 'text',
                    text = ~paste0(city, ', ', provstate, '<br />', date, '<br /> People killed:', nkill, '<br /> People injured', nwound)) %>%
      layout(title = 'Impact of Terrorist Activity for Given Year',
             margin = list(t = 100, b = 100),
             xaxis = list(title = 'Date', tickangle = 90),
             yaxis = list(title = 'Total Combined Deaths and Injuries')
      )
  }
  
  return(plot)
}
