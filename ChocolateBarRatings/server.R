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
source("facts.R")

#setwd("~/Desktop/Chocolate-Bar-Ratings")
chocolate <- read.csv("./flavors_of_cacao.csv", header = TRUE, stringsAsFactors = FALSE, fileEncoding="UTF-8")

# Define server logic required to draw table 
shinyServer(function(input, output) {
  fact <- eventReactive(input$factButton, {
    generateFact()
  })
  
  output$randomFact <- renderText({
    if (is.null(input$factButton) || input$factButton == 0) {
      generateFact()
    }
    else {
      fact()
    }
  })
  
  output$table <- renderDataTable({
    data <- chocolate
    data$Specific.Bean.Origin.or.Bar.Name <- NULL
    data$REF <- NULL
    data$Review.Date <- NULL
    data$Bean.Type <- NULL

    f <- function(x) {
      substring(x, 1, nchar(x)-1)
    }
    n <- lapply(data$Cocoa.Percent, f)
    n <- as.integer(n)
    
    b1 <- n >= input$cocao[1] 
    b2 <- n <= input$cocao[2]
    data <- filter(data, b1 & b2)
    if (input$beanorigin != "No Preference") {
      data <- filter(data, Broad.Bean.Origin == input$beanorigin)
    }
    if (input$country != "Any") {
      data <- filter(data, Company.Location == input$country)
    }
    data <- arrange(data, desc(Rating))
  },
    options = list(orderClasses = TRUE,
                   lengthMenu = list(c(25,50,75,100,-1), c('25','50','75','100','All')),
                   pageLength = 25,
                   columns = list(
                     list(title = 'Company'),
                     list(title = 'Cocoa Percent'),
                     list(title = 'Location'),
                     NULL,
                     list(title = 'Bean Origin')
                   ),
                   ordering = F
    )
  )
  
  output$distPlot <- renderPlot({
    # if else to select what variable is being chosen to be grouped by
    if(input$property == "Company") {
      #group by
      relevant_data <- group_by(chocolate, Company..Maker.if.known.) 
      #summarise the rating
      rating_mean <- summarise(relevant_data, mean_rating = mean(Rating)) %>% arrange(desc(mean_rating))  
      #taking the top 10
      rating_mean <- head(rating_mean, 10) 
      #plot
      ggplot(rating_mean, aes(Company..Maker.if.known., mean_rating)) + 
        geom_col(aes(fill = Company..Maker.if.known.)) + 
        geom_text(aes(Company..Maker.if.known., mean_rating, label=round(mean_rating, digits=2)), vjust = 2, color = "white") +
        labs(title = paste("Top Ten Cacao by", input$property), x = input$property, y = "Rating") +
        theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
        theme(legend.position="none")
    } else if(input$property == "Location") {
      relevant_data <- group_by(chocolate, Company.Location)
      rating_mean <- summarise(relevant_data, mean_rating = mean(Rating)) %>% arrange(desc(mean_rating))    
      rating_mean <- head(rating_mean, 10)
      ggplot(rating_mean, aes(Company.Location, mean_rating)) + 
        geom_col(aes(fill = Company.Location)) + 
        geom_text(aes(Company.Location, mean_rating, label=round(mean_rating, digits=2)), vjust = 2, color = "white") +
        labs(title = paste("Top Ten Cacao by", input$property), x = input$property, y = "Rating") + 
        theme(axis.text.x = element_text(angle = 60, hjust = 1)) + 
        theme(legend.position="none")
    } else if(input$property == "Cocoa Percent") {
      relevant_data <- group_by(chocolate, Cocoa.Percent)
      rating_mean <- summarise(relevant_data, mean_rating = mean(Rating)) %>% arrange(desc(mean_rating))    
      rating_mean <- head(rating_mean, 10)
      ggplot(rating_mean, aes(Cocoa.Percent, mean_rating)) + 
        geom_col(aes(fill = Cocoa.Percent)) + 
        geom_text(aes(Cocoa.Percent, mean_rating, label=round(mean_rating, digits=2)), vjust = 2, color = "white") +
        labs(title = paste("Top Ten Cacao by", input$property), x = input$property, y = "Rating") + 
        theme(legend.position="none")
    } else {
      relevant_data <- group_by(chocolate, Broad.Bean.Origin)
      rating_mean <- summarise(relevant_data, mean_rating = mean(Rating)) %>% arrange(desc(mean_rating))    
      rating_mean <- head(rating_mean, 10)
      ggplot(rating_mean, aes(Broad.Bean.Origin, mean_rating)) + 
        geom_col(aes(fill = Broad.Bean.Origin)) + 
        geom_text(aes(Broad.Bean.Origin, mean_rating, label=round(mean_rating, digits=2)), vjust = 2, color = "white") +
        labs(title = paste("Top Ten Cacao by", input$property), x = input$property, y = "Rating") + 
        theme(axis.text.x = element_text(angle = 60, hjust = 1)) + 
        theme(legend.position="none")
    }
    
  })
  
})