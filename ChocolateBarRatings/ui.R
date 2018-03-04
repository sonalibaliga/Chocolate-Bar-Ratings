#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Chocolate Bar Ratings"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "cocao%", label = "What cocoa percentage would you like in your chocolate(s)?",
                  min = 40, max = 100, value = c(60, 80)),
      checkboxGroupInput("company", "Which country/countries do you want your chocolate to be availible in?",
                   choices =  list("Brazil"="Brazil","Canada"="Canada","Chile"="Chile","Colombia"="Colombia","Costa Rica"="Costa Rica",
                                   "Czech Republic"="Czech Republic","Denmark"="Denmark","Domincan Republic"="Domincan Republic",
                                   "Ecuador"="Ecuador","Fiji"="Fiji","Finland"="Finland","France"="France","Germany"="Germany", 
                                   "Ghana"="Ghana","Grenada"="Grenada","Guatemala"="Guatemala","Honduras"="Honduras","Hungary"="Hungary",
                                   "Iceland"="Iceland","India"="India","Ireland"="Ireland","Israel"="Israel","Italy"="Italy","Japan"="Japan",
                                   "Lithuania"="Lithuania","Madagascar"="Madagascar","Martinique"="Martinique","Mexico"="Mexico","Nertherlands"="Nertherlands",
                                   "New Zealand"="New Zealand","Nicaragua"="Nicaragua","Peru"="Peru","Philippines"="Philippines","Poland"="Poland", 
                                   "Portugal"="Portugal","Puerto Rico"="Puerto Rico","Russia"="Russia","Sao Tome"="Sao Tome","Scotland"="Scotland",
                                   "Singapore"="Singapore","South Africa"="South Africa","South Korea"="South Korea","Spain"="Spain","St.Lucia"="St.Lucia",
                                   "Suriname"="Suriname","Sweden"="Sweden","Switzerland"="Switzerland","U.K"="U.K","U.S.A"="U.S.A",
                                   "Venezuela"="Venezuela","Vietnam"="Vietnam","Wales"="Wales")),
      textInput("beanorigin", "Choose a bean origin preferance, if any.", "If none, type NONE")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
       tabPanel("User Documentation", vertatimTextOutput("User Documentation")),
       tabPanel("Interactive",),
       tabPanel("Interactive2",)
      )
       plotOutput("distPlot")
    )
  )
))
