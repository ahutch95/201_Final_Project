# ui.R
library(shiny)
library(plotly)

shinyUI(navbarPage('Terrorism over Time',
                   # tab panel for a map
                   tabPanel('Map',
                            titlePanel('Map of Attacks'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                
                                #Widgets
                                selectInput("RegionMap", label = h3("Select Region"), 
                                            choices = list("All", "Australasia/Oceania", "Central America", "Central Asia", "East Asia", "Eastern Europe", "Middle East/North Africa", "North America", "South America", "South Asia", "Southeast Asia", "Sub-Saharan Africa", "Western Europe"), 
                                            selected = "All"),
                                sliderInput("YearsMap", label = h3("Time Range"), sep = "", min = 1970, 
                                            max = 2015, value = c(1970, 2015)),
                                selectInput("TargetTypeMap", label = h3("Select based on Target Type"), 
                                            choices = list("All", "Business","Government","Police","Military","Abortion Related", "Airports & Aircraft", "Government(Diplomatic)", "Educational Institution", "Food or Water Supply", "Journalist & Media", "Maritime", "NGO", "Other", "Private Citizens & Property"), 
                                            selected = "All"),
                                selectInput("AttackTypeMap", label = h3("Select based on Attack Type"), 
                                            choices = list("All", "Assassination", "Armed Assault", "Bombing/Explosion", "Hijacking", "Hostage Taking (Barricade Incident)", "Hostage Taking (Kidnapping)", "Facility/Infrastructure Attack", "Unarmed Assault", "Unknown"), 
                                            selected = "All"),
                                selectInput("WeaponTypeMap", label = h3("Select based on Weapon Type"), 
                                            choices = list("All", "Biological", "Chemical", "Radiological", "Nuclear", "Firearms", "Explosives/Bombs/Dynamite", "Fake Weapons", "Incendiary", "Melee", "Vehicle", "Sabotage Equipment", "Other", "Unknown"), 
                                            selected = "All")
                              ),
                              
                              # Main panel: display plotly map
                              mainPanel(
                                plotlyOutput('map'),
                                textOutput("text")
                              )
                            )
                   ), 
                   
                   # tabPanel for a scatter plot
                   tabPanel('Pie Charts',
                            # Add a titlePanel to your tab
                            titlePanel('Pie Chart Breakdown'),
                            
                            # Create a sidebar layout for this tab (page)
                            sidebarLayout(
                              
                              # Create a sidebarPanel for your controls
                              sidebarPanel(
                                
                                # Widgets
                                selectInput("RegionPie", label = h3("Select Region"), 
                                            choices = list("All", "Australasia/Oceania", "Central America", "Central Asia", "East Asia", "Eastern Europe", "Middle East/North Africa", "North America", "South America", "South Asia", "Southeast Asia", "Sub-Saharan Africa", "Western Europe"), 
                                            selected = "All"),
                                sliderInput("YearsPie", label = h3("Time Range"), sep = "", min = 1970, 
                                            max = 2015, value = c(1970, 2015)),
                                selectInput("TypePie", label = h3("Select based on Attack Type, Target, or Weapon Type"), 
                                            choices = list( "None", "Target Type", "Attack Type", "Weapon Type"), 
                                            selected = "None")
                              ),
                              
                              # Create a main panel, to display plotly pie
                              mainPanel(
                                plotlyOutput('pies')
                              )
                            )
                   ),
                   tabPanel('Time',
                            # Add a titlePanel to your tab
                            titlePanel('Time Chart of Attacks'),
                            
                            # Create a sidebar layout for this tab (page)
                            sidebarLayout(
                              
                              # Create a sidebarPanel for your controls
                              sidebarPanel(
                                
                                # Widgets
                                selectInput("RegionTime", label = h3("Select Region"), 
                                            choices = list("All", "Australasia/Oceania", "Central America", "Central Asia", "East Asia", "Eastern Europe", "Middle East/North Africa", "North America", "South America", "South Asia", "Southeast Asia", "Sub-Saharan Africa", "Western Europe"), 
                                            selected = "All"),
                                sliderInput("YearsTime", label = h3("Time Range"), sep = "", min = 1970, 
                                            max = 2015, value = c(1970, 2015)),
                                selectInput("TargetTypeTime", label = h3("Select based on Target Type"), 
                                            choices = list("All", "Business","Government","Police","Military","Abortion Related", "Airports & Aircraft", "Government(Diplomatic)", "Educational Institution", "Food or Water Supply", "Journalist & Media", "Maritime", "NGO", "Other", "Private Citizens & Property"), 
                                            selected = "All"),
                                selectInput("AttackTypeTime", label = h3("Select based on Attack Type"), 
                                            choices = list("All", "Assassination", "Armed Assault", "Bombing/Explosion", "Hijacking", "Hostage Taking (Barricade Incident)", "Hostage Taking (Kidnapping)", "Facility/Infrastructure Attack", "Unarmed Assault", "Unknown"), 
                                            selected = "All"),
                                selectInput("WeaponTypeTime", label = h3("Select based on Weapon Type"), 
                                            choices = list("All", "Biological", "Chemical", "Radiological", "Nuclear", "Firearms", "Explosives/Bombs/Dynamite", "Fake Weapons", "Incendiary", "Melee", "Vehicle", "Sabotage Equipment", "Other", "Unknown"), 
                                            selected = "All")
                              ),
                              
                              # Create a main panel, to display plotly Scatter plot
                              mainPanel(
                                #plotlyOutput('time')
                                
                              )
                            )
                   )
                   
))

#target type <- list("Business"=1,"Government"=2,"Police"=3,"Military"=4,"Abortion Related"=5, "Airports & Aircraft"=6, "Government(Diplomatic)"=7, "Educational Institution"=8, "Food or Water Supply"=9, "Journalist & Media"=10, "Maritime"=11, "NGO"=12, "Other"=13, "Private Citizens & Property"=14), 
#attack type <- list("Assassination"=15, "Armed Assault"=16, "Bombing/Explosion"=17, "Hijacking"=18, "Hostage Taking (Barricade Incident)"=19, "Hostage Taking (Kidnapping)"=20, "Facility/Infrastructure Attack"=21, "Unarmed Assault"=22, "Unknown"=23), 
#weapon type <- list("Biological"=24, "Chemical"=25, "Radiological"=26, "Nuclear"=27, "Firearms"=28, "Explosives/Bombs/Dynamite"=29, "Fake Weapons"=30, "Incendiary"=31, "Melee"=32, "Vehicle"=33, "Sabotage Equipment"=34, "Other"=35, "Unknown"=36)), 