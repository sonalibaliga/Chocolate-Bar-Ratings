#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

#setwd("~/Desktop/Chocolate-Bar-Ratings")
chocolate <- read.csv("./ChocolateBarRatings/flavors_of_cacao.csv", sep = "\t", header = TRUE, stringsAsFactors = FALSE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    if(input$property == "Company") {
      relevant_data <- group_by(chocolate, Company...Maker.if.known.)
      rating_mean <- summarise(relevant_data, mean_rating = mean(Rating)) %>% arrange(desc(mean_rating))    
      rating_mean <- head(rating_mean, 10)
      ggplot(rating_mean, aes(Company...Maker.if.known., mean_rating)) + geom_col()
    } else if(input$property == "Location") {
      relevant_data <- group_by(chocolate, Company.Location)
      rating_mean <- summarise(relevant_data, mean_rating = mean(Rating)) %>% arrange(desc(mean_rating))    
      rating_mean <- head(rating_mean, 10)
      ggplot(rating_mean, aes(Company.Location, mean_rating)) + geom_col()
    } else if(input$property == "Cocoa Percent") {
      relevant_data <- group_by(chocolate, Cocoa.Percent)
      rating_mean <- summarise(relevant_data, mean_rating = mean(Rating)) %>% arrange(desc(mean_rating))    
      rating_mean <- head(rating_mean, 10)
      ggplot(rating_mean, aes(Cocoa.Percent, mean_rating)) + geom_col()
    } else {
      relevant_data <- group_by(chocolate, Broad.Bean.Origin)
      rating_mean <- summarise(relevant_data, mean_rating = mean(Rating)) %>% arrange(desc(mean_rating))    
      rating_mean <- head(rating_mean, 10)
      ggplot(rating_mean, aes(Broad.Bean.Origin, mean_rating)) + geom_col()
    }
    
  })
  
})
