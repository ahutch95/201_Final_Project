# ui.R
library(shiny)
library(plotly)

shinyUI(navbarPage('Title',
                   # tab panel for a map
                   tabPanel('Map',
                            titlePanel('Tab 1 Title'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                
                                #Widgets
                                
                                
                              ),
                              
                              # Main panel: display plotly map
                              mainPanel(
                                #plotlyOutput('map')
                              )
                            )
                   ), 
                   
                   # tabPanel for a scatter plot
                   tabPanel('Scatter',
                            # Add a titlePanel to your tab
                            titlePanel('Tab 2 Title'),
                            
                            # Create a sidebar layout for this tab (page)
                            sidebarLayout(
                              
                              # Create a sidebarPanel for your controls
                              sidebarPanel(
                                
                                # Widgets
                              ),
                              
                              # Create a main panel, to display plotly Scatter plot
                              mainPanel(
                                #plotlyOutput('scatter')
                              )
                            )
                   )
))