#load data containing ratings of draught players in the Netherlands
mydata<-read.table("rat_provs.csv", header = T, sep = ",")
#filter uniek provinces so they can be used in the select input boxes
provinces<-paste(unique(mydata$PROVINCIE)[2:13])

#load libraries
library(shiny)

#start ui
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Strength of draught players in Dutch provinces"),
  
  # Sidebar with two select input boxes 
  sidebarLayout(
    sidebarPanel(
            h3("Select here the two provinces that you want to compare"),
            selectInput('provinces1', 'Select Province 1 :',choices = provinces, multiple = F),
            selectInput('provinces2', 'Select Province 2:',choices = provinces, multiple = F)),
    
    # Show a plot of two selected provinces
    mainPanel(

       plotOutput("histPlot") 
    )
  )
))
