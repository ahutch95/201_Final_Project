# ui.R
library(shiny)
library(plotly)

shinyUI(navbarPage('Terrorism over Time',
                   # tab for homepage
                   tabPanel('About',
                            titlePanel('About This Project'),
                            sidebarLayout(
                              sidebarPanel(
                                h3('Created By'),
                                h4('Alyssa Holzer, Austin Hutchinson, Jake Therrien, and Lee Polla'),
                                h3('Data Citation'),
                                p('National Consortium for the Study of Terrorism and Responses to Terrorism (START). (2016). Global Terrorism Database [Data file]. Retrieved from https://www.start.umd.edu/gtd')
                              ),
                              mainPanel(
                                h2('Introduction'),
                                p('The Global Terrorism Database (GTD) is an open-source database including information on terrorist events around the world since 1970 (our project looks specifically at 2000-2015). Unlike many other event databases, the GTD includes systematic data on international as well as domestic terrorist incidents that have occurred during this time period and now includes over 113,000 cases. For each GTD incident, information is available on the date and location of the incident, the weapons used and nature of the target, the number of casualties, and -- when identifiable -- the identity of the perpetrator.'),
                                h2('Disclaimer'),
                                p('The purpose of this project is to provide an exploratory tool for learning about trends in terrorism. This project is not meant to give a characterization of any particular terrorists or extremist groups. The GTD defines terrorism as: \"The threatened or actual use of illegal force and violence by a non-state actor to attain a political, economic, religious, or social goal through fear, coercion, or intimidation.\" Characterizing all terrorist activity as an \'attack\' can also be problematic, because this characterizes terrorists as enemies or evil, which rhetorically excludes the possibility that terrorists may have a legitimate reason to use illegal force. Additionally, the GTD was built using data from highly publicized news articles, so it might be the case that some terrorist activities are excluded or wrongfully included because of how the media chooses to represent the event.')
                              )
                            )
                   ),
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
                                sliderInput("YearsMap", label = h3("Time Range"), sep = "", min = 2000, 
                                            max = 2015, value = c(2000, 2015)),
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
                                h2("About this visualization"),
                                h3("Terrorist Activity Map"),
                                p("This map shows the locations of recorded terrorist activity and the size of points is determined by the number of people killed"),
                                p("Selecting a range of years will show the map of terrorist activity for the selected years. Changing the type will show different points on the map for target type, attack type or weapon type. Selecting different regions will change the underlying map that is displayed"),
                                p("This chart can be used to answer various questions about the locations of terrorist activity, including the following:"),
                                HTML("<ul><li>How does the severity of terrorist activity relate to their location?</li>",
                                     "<li>Does it look like terrorist activity are concentrated around government centers, civilian areas or other?</li>",
                                     "<li>Does the type of attack or weapon relate to geography in any way?</li></ul><br /><br />")
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
                                sliderInput("YearsPie", label = h3("Time Range"), sep = "", min = 2000, 
                                            max = 2015, value = c(2000, 2015)),
                                selectInput("TypePie", label = h3("Select based on Attack Type, Target, or Weapon Type"), 
                                            choices = list("Target", "Attack", "Weapon"), 
                                            selected = "Target")
                              ),
                              
                              # Create a main panel, to display plotly pie
                              mainPanel(
                                plotlyOutput('pies'),
                                h2("About this visualization"),
                                h3("Terrorist Activity Type Breakdown"),
                                p("Selecting a range of years will show the breakdown of terrorist activity for the selected years. Changing the type will show different pie charts for breakdowns by target type, attack type or weapon type. "),
                                p("This chart can be used to answer various questions about the breakdown of types of terrorist activity, including the following:"),
                                HTML("<ul><li>What targets are being targeted most frequently? Government facilities, commercial centers, living spaces? Does this make it seem like terrorist attacks are personally, politically or economically motivated?</li>",
                                     "<li>What types of weapons or attacks are used most frequently? Has this changed over time? Does this suggest that terrorist activities are well organized or not?</li></ul><br /><br />")
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
                                sliderInput("YearsTime", label = h3("Time Range"), sep = "", min = 2000, 
                                            max = 2015, value = c(2000, 2015)),
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
                                plotlyOutput('time'),
                                textOutput('summary'),
                                h2("About this visualization"),
                                h3("Time Series Chart"),
                                p("Selecting a range of years will show the total number of events for each year in the selected range. Selecting only a single year will show the date for each individual event in that year and the combined number of people killed and wounded in that event."),
                                p("This chart can be used to answer various questions about the level of terrorist activity over time, including the following:"),
                                HTML("<ul><li>How has the rate of terrorist activity changed over time in across the world? In specific regions?</li>",
                                     "<li>Which years were especially violent for specific regions?</li>",
                                     "<li>What kinds of weapons were used most in earlier years and how has this changed over time?</li>",
                                     "<li>Are there any trends in target type in a single year for any or all regions?</li></ul><br /><br />"
                                )
                              )
                            )
                   )
                   
))

#target type <- list("Business"=1,"Government"=2,"Police"=3,"Military"=4,"Abortion Related"=5, "Airports & Aircraft"=6, "Government(Diplomatic)"=7, "Educational Institution"=8, "Food or Water Supply"=9, "Journalist & Media"=10, "Maritime"=11, "NGO"=12, "Other"=13, "Private Citizens & Property"=14), 
#attack type <- list("Assassination"=15, "Armed Assault"=16, "Bombing/Explosion"=17, "Hijacking"=18, "Hostage Taking (Barricade Incident)"=19, "Hostage Taking (Kidnapping)"=20, "Facility/Infrastructure Attack"=21, "Unarmed Assault"=22, "Unknown"=23), 
#weapon type <- list("Biological"=24, "Chemical"=25, "Radiological"=26, "Nuclear"=27, "Firearms"=28, "Explosives/Bombs/Dynamite"=29, "Fake Weapons"=30, "Incendiary"=31, "Melee"=32, "Vehicle"=33, "Sabotage Equipment"=34, "Other"=35, "Unknown"=36)), 