# ui.R
library(shiny)
library(plotly)

shinyUI(navbarPage('Terrorism over Time',
                   # tab panel for a map
                   tabPanel('Map',
                            titlePanel('Tab 1 Title'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                
                                #Widgets
                                selectInput("Region", label = h3("Select Region"), 
                                            choices = list("All", "Australasia/Oceania", "Central America", "Central Asia", "East Asia", "Eastern Europe", "Middle East/North America", "North America", "South America", "South Asia", "Southeast Asia", "Sub-Saharan Africa", "Western Europe"), 
                                            selected = "All"),
                                sliderInput("Years", label = h3("Time Range"), sep = "", min = 1970, 
                                            max = 2015, value = c(1970, 2015)),
                                selectInput("Type", label = h3("Select Attack, Target, or Weapon Type"), 
                                            choices = list( "None",
                                                           "Target Type" = list("Business"=1,"Government"=2,"Police"=3,"Military"=4,"Abortion Related"=5, "Airports & Aircraft"=6, "Government(Diplomatic)"=7, "Educational Institution"=8, "Food or Water Supply"=9, "Journalist & Media"=10, "Maritime"=11, "NGO"=12, "Other"=13, "Private Citizens & Property"=14), 
                                                           "Attack Type" = list("Assassination"=1, "Armed Assault"=2, "Bombing/Explosion"=3, "Hijacking"=4, "Hostage Taking (Barricade Incident)"=5, "Hostage Taking (Kidnapping)"=6, "Facility/Infrastructure Attack"=7, "Unarmed Assault"=8, "Unknown"=9), 
                                                           "Weapon Type" = list("Biological"=1, "Chemical"=2, "Radiological"=3, "Nuclear"=4, "Firearms"=5, "Explosives/Bombs/Dynamite"=6, "Fake Weapons"=7, "Incendiary"=8, "Melee"=9, "Vehicle"=10, "Sabotage Equipment"=11, "Other"=12, "Unknown"=13)), 
                                            selected = "None")
                              ),
                              
                              # Main panel: display plotly map
                              mainPanel(
                                plotlyOutput('map')
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
                                selectInput("Region", label = h3("Select Region"), 
                                            choices = list("All", "Australasia/Oceania", "Central America", "Central Asia", "East Asia", "Eastern Europe", "Middle East/North America", "North America", "South America", "South Asia", "Southeast Asia", "Sub-Saharan Africa", "Western Europe"), 
                                            selected = "All"),
                                sliderInput("Years", label = h3("Time Range"), sep = "", min = 1970, 
                                            max = 2015, value = c(1970, 2015)),
                                selectInput("Type", label = h3("Select Attack, Target, or Weapon Type"), 
                                            choices = list( "None",
                                                            "Target Type" = list("Business"=1,"Government"=2,"Police"=3,"Military"=4,"Abortion Related"=5, "Airports & Aircraft"=6, "Government(Diplomatic)"=7, "Educational Institution"=8, "Food or Water Supply"=9, "Journalist & Media"=10, "Maritime"=11, "NGO"=12, "Other"=13, "Private Citizens & Property"=14), 
                                                            "Attack Type" = list("Assassination"=1, "Armed Assault"=2, "Bombing/Explosion"=3, "Hijacking"=4, "Hostage Taking (Barricade Incident)"=5, "Hostage Taking (Kidnapping)"=6, "Facility/Infrastructure Attack"=7, "Unarmed Assault"=8, "Unknown"=9), 
                                                            "Weapon Type" = list("Biological"=1, "Chemical"=2, "Radiological"=3, "Nuclear"=4, "Firearms"=5, "Explosives/Bombs/Dynamite"=6, "Fake Weapons"=7, "Incendiary"=8, "Melee"=9, "Vehicle"=10, "Sabotage Equipment"=11, "Other"=12, "Unknown"=13)), 
                                            selected = "None")
                              ),
                              
                              # Create a main panel, to display plotly Scatter plot
                              mainPanel(
                                #plotlyOutput('scatter')
                              )
                            )
                   ),
                   tabPanel('Time',
                            # Add a titlePanel to your tab
                            titlePanel('Tab 3 Title'),
                            
                            # Create a sidebar layout for this tab (page)
                            sidebarLayout(
                              
                              # Create a sidebarPanel for your controls
                              sidebarPanel(
                                
                                # Widgets
                                selectInput("Region", label = h3("Select Region"), 
                                            choices = list("All", "Australasia/Oceania", "Central America", "Central Asia", "East Asia", "Eastern Europe", "Middle East/North America", "North America", "South America", "South Asia", "Southeast Asia", "Sub-Saharan Africa", "Western Europe"), 
                                            selected = "All"),
                                sliderInput("Years", label = h3("Time Range"), sep = "", min = 1970, 
                                            max = 2015, value = c(1970, 2015)),
                                selectInput("Type", label = h3("Select Attack, Target, or Weapon Type"), 
                                            choices = list( "None",
                                                            "Target Type" = list("Business"=1,"Government"=2,"Police"=3,"Military"=4,"Abortion Related"=5, "Airports & Aircraft"=6, "Government(Diplomatic)"=7, "Educational Institution"=8, "Food or Water Supply"=9, "Journalist & Media"=10, "Maritime"=11, "NGO"=12, "Other"=13, "Private Citizens & Property"=14), 
                                                            "Attack Type" = list("Assassination"=1, "Armed Assault"=2, "Bombing/Explosion"=3, "Hijacking"=4, "Hostage Taking (Barricade Incident)"=5, "Hostage Taking (Kidnapping)"=6, "Facility/Infrastructure Attack"=7, "Unarmed Assault"=8, "Unknown"=9), 
                                                            "Weapon Type" = list("Biological"=1, "Chemical"=2, "Radiological"=3, "Nuclear"=4, "Firearms"=5, "Explosives/Bombs/Dynamite"=6, "Fake Weapons"=7, "Incendiary"=8, "Melee"=9, "Vehicle"=10, "Sabotage Equipment"=11, "Other"=12, "Unknown"=13)), 
                                            selected = "None")
                              ),
                              
                              # Create a main panel, to display plotly Scatter plot
                              mainPanel(
                                #plotlyOutput('time')
                              )
                            )
                   )
                   
))