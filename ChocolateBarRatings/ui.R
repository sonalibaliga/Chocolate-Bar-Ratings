library(shiny)
library(markdown)

shinyUI(fluidPage(theme="style.css",
                  
  headerPanel(title=div(img(src="cocoa.png"), "Flavors of Cacao Ratings"), windowTitle = "Flavors of Cacao Ratings"),
  
  headerPanel(""),
  headerPanel(""),
  headerPanel(""),
  headerPanel(""),
  headerPanel(""),
  
  sidebarPanel(
    
    conditionalPanel(condition="input.selectedtab==1",h4("This panel will be used to display some important information that we want to stand out to our users when they first load this application. Useful info or maybe even an introduction will suffice."), 
                     tags$br(), 
                     h4("Content to be added later.")),
    conditionalPanel(condition="input.selectedtab==2",
                     sliderInput(inputId = "cocao", label = "Cocoa Percentage Range",
                                 min = 40, max = 100, value = c(60, 80)),
                     selectInput("beanorigin", "Choose a bean origin preference (if any)",
                                 choices = list("NONE"="NONE","Australia"="Australia","Belize"="Belize","Bolivia"="Bolivia","Brazil"="Brazil","Burma"="Burma","Cameroon"="Cameroon",
                                                "Carribean"="Carribean","Colombia"="Colombia","Congo"="Congo","Costa Rica"="Costa Rica","Cuba"="Cuba","Dominican Republic"="Dominican Republic",
                                                "Ecuador"="Ecuador","El Salvador"="El Salvador","Fiji"="Fiji","Gabon"="Gabon","Ghana"="Ghana","Grenada"="Grenada","Guatemala"="Guatemala",
                                                "Haiti"="Haiti","Hawaii"="Hawaii","Honduras"="Honduras","India"="India","Indonesia"="Indonesia","Ivory Coast"="Ivory Coast","Jamaica"="Jamaica",
                                                "Liberia"="Liberia","Madagascar"="Madagascar","Malaysia"="Malaysia","Martinique"="Martinique","Mexico"="Mexico","Nicaragua"="Nicaragua","Peru"="Peru",
                                                "Philippines"="Philippines","PNG"="PNG","Principe"="Principe","Puerto Rico"="Puerto Rico","Samoa"="Samoa","Sao Tome"="Sao Tome","Solomon Islands"="Solomon Islands",
                                                "South America"="South America","Sri Lanka"="Sri Lanka","St. Lucia"="St. Lucia","Suriname"="Suriname","Tanzania"="Tanzania","Tobago"="Tobago","Togo"="Togo","Trinidad"="Trinidad",
                                                "Uganda"="Uganda","Vanuatu"="Vanuatu","Vanezuela"="Vanezuela","Vietnam"="Vietnam","West Africa"="West Africa"), selected = "NONE"),
                     checkboxGroupInput("country", "Country/Countries the cacao company is availible in",
                                        choices =  list("NONE"="NONE","Brazil"="Brazil","Canada"="Canada","Chile"="Chile","Colombia"="Colombia","Costa Rica"="Costa Rica",
                                                        "Czech Republic"="Czech Republic","Denmark"="Denmark","Domincan Republic"="Domincan Republic",
                                                        "Ecuador"="Ecuador","Fiji"="Fiji","Finland"="Finland","France"="France","Germany"="Germany",
                                                        "Ghana"="Ghana","Grenada"="Grenada","Guatemala"="Guatemala","Honduras"="Honduras","Hungary"="Hungary",
                                                        "Iceland"="Iceland","India"="India","Ireland"="Ireland","Israel"="Israel","Italy"="Italy","Japan"="Japan",
                                                        "Lithuania"="Lithuania","Madagascar"="Madagascar","Martinique"="Martinique","Mexico"="Mexico","Nertherlands"="Nertherlands",
                                                        "New Zealand"="New Zealand","Nicaragua"="Nicaragua","Peru"="Peru","Philippines"="Philippines","Poland"="Poland",
                                                        "Portugal"="Portugal","Puerto Rico"="Puerto Rico","Russia"="Russia","Sao Tome"="Sao Tome","Scotland"="Scotland",
                                                        "Singapore"="Singapore","South Africa"="South Africa","South Korea"="South Korea","Spain"="Spain","St.Lucia"="St.Lucia",
                                                        "Suriname"="Suriname","Sweden"="Sweden","Switzerland"="Switzerland","U.K"="U.K","U.S.A"="U.S.A",
                                                        "Venezuela"="Venezuela","Vietnam"="Vietnam","Wales"="Wales"), selected = "NONE")
    ),
    
    conditionalPanel(condition="input.selectedtab==3",
                     selectInput("property", label = "Choose a property to filter ratings by",
                                 choices = list("Company"="Company", "Cocoa Percent"="Cocoa Percent", "Location"="Location",
                                                "Broad Bean Origin"="Broad Bean Origin"),
                                 selected = "Cocoa Percent")
    )
    
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Documentation", value=1, icon=icon("book", lib="font-awesome"), includeMarkdown("www/docs.md")),
      tabPanel("Table", value=2, icon=icon("table", lib="font-awesome"), dataTableOutput("table")),
      tabPanel("Cacao Visualizations", value=3, icon=icon("bar-chart-o", lib="font-awesome"), plotOutput("distPlot")), 
      id = "selectedtab"
      )
  )
))