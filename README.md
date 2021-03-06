﻿# 201_Final_Project

# Project Description

In this project, we plan to utilize the START Consortium’s Global Terrorism Database. This dataset contains data that was collected over the years of 1970-2015 by the National Consortium for the Study of Terrorism and Responses to Terrorism led by the University of Maryland. Found on Kaggle.com, this dataset provides statistics on known acts of terrorism around the world. We believe that this data will be most used by those researching terrorism and those in the counter-terrorism field. With the appropriate analysis we hope to find a deeper understanding of terrorism and its impact on citizens. 

For our audience who is unfamiliar with these ideas, we want to illustrate how changes in terrorism can be related to other types of political events. In order to answer these questions, we will employ maps as well as various charts and graphs to help clearly illustrate our findings. 

Questions
* How did terrorism change after the 2003 invasion of Iraq?
* How many terrorist attacks targeted government and other public officials in Chile and other latin American countries during the 2000s? How did the type of weapon change before and after events in the 2000s?(The U.S. funded and trained many of these groups)
* How did the rate and level of terrorism change throughout the decades?


# Technical Description

* The format of the final product of this project will be an HTML page hosted on the UW student server.
* The data that we will be using comes from a .csv file provided by Kaggle.
* The data has many columns to describe specific situations that are null for most rows, so we will be filtering for these situations when necessary. Some columns store textual descriptions of the events and these strings may be parsed to help filter the rows into new groups.
* All of the libraries we will be using in this project to manipulate the data and create our html page have been covered previously in this course.
* Many of our questions about the data will be answered by comparing analytics on subgroups to the averages of the outgroups or the data as a whole.
* We anticipate having to read through a lot of the event descriptions before we can figure out an effective way to filter for the events we want. It will also require some effort to do research on political timelines from other sources to correlate events effectively.

# Note
* There may be an error in the file encoding when loading the datasets on Windows. Some machines might not be able to load the dataset depending on the choice of file encoding. We found that trying both "UTF-8" and "latin1" fileEncoding when reading the csv's was necessary sometimes in order to load the data properly. 
* Depending on your version of R, the plotly pie chart labels might be cut off at the bottom
