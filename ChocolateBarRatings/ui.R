library(shiny)
shinyUI(fluidPage(theme="bootstrap.css",
  
  headerPanel("Chocolate Bar Ratings"),
  sidebarPanel(
    
    ## conditionalPanel() functions for selected tab
    conditionalPanel(condition="input.selectedtab==1",h4("Some information that we want to emphasize with the documentation will go here. This is for information that we want to \"Stand out\"")),
    conditionalPanel(condition="input.selectedtab==2",
                     sliderInput(inputId = "cocao%", label = "Choose a cocoa percentage range for your chocolate(s)",
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
                     
                     selectInput("beanorigin", "Choose a bean origin preferance, if any.", "If none, choose NONE",
                                 choices = list("Australia"="Australia","Belize"="Belize","Bolivia"="Bolivia","Brazil"="Brazil","Burma"="Burma","Cameroon"="Cameroon",
                                                "Carribean"="Carribean","Colombia"="Colombia","Congo"="Congo","Costa Rica"="Costa Rica","Cuba"="Cuba","Dominican Republic"="Dominican Republic",
                                                "Ecuador"="Ecuador","El Salvador"="El Salvador","Fiji"="Fiji","Gabon"="Gabon","Ghana"="Ghana","Grenada"="Grenada","Guatemala"="Guatemala",
                                                "Haiti"="Haiti","Hawaii"="Hawaii","Honduras"="Honduras","India"="India","Indonesia"="Indonesia","Ivory Coast"="Ivory Coast","Jamaica"="Jamaica",
                                                "Liberia"="Liberia","Madagascar"="Madagascar","Malaysia"="Malaysia","Martinique"="Martinique","Mexico"="Mexico","Nicaragua"="Nicaragua","Peru"="Peru",
                                                "Philippines"="Philippines","PNG"="PNG","Principe"="Principe","Puerto Rico"="Puerto Rico","Samoa"="Samoa","Sao Tome"="Sao Tome","Solomon Islands"="Solomon Islands",
                                                "South America"="South America","Sri Lanka"="Sri Lanka","St. Lucia"="St. Lucia","Suriname"="Suriname","Tanzania"="Tanzania","Tobago"="Tobago","Togo"="Togo","Trinidad"="Trinidad",
                                                "Uganda"="Uganda","Vanuatu"="Vanuatu","Vanezuela"="Vanezuela","Vietnam"="Vietnam","West Africa"="West Africa"), multiple = TRUE),
                     verbatimTextOutput("selected"),
    
    conditionalPanel(condition="input.selectedtab==3",
                     selectInput("property", label = "Choose a property to filter ratings by",
                                 choices = list("Company"="Company", "Specific Bean Origin"="Specific Bean Origin", "Cocoa Percent"="Cocoa Percent", "Location"="Location",
                                                "Bean Type"="Bean Type", "Broad Bean Origin"="Broad Bean Origin"),
                                 selected = "Cocoa Percent"),
                     ## figure out a way to make max the max number of options possible through some sort of variable manipulation
                     sliderInput(inputId = "numratings", label = "Choose the quantity of ratings to show",
                                 min = 1, max = 1795, value=1)
                     )
    
  ),
  mainPanel(
    # do not change tabpanel values
    tabsetPanel(
      tabPanel("Documentation", value=1, helpText("This is placeholder text for our documentation.
                                          ")),
      tabPanel("Table", value=2 ## Figure out outputs 
               ),
      tabPanel("Ratings Visualization", value=3, plotOutput("distPlot")), 
      id = "selectedtab"
      )
    )
  ))