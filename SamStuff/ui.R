# Didn't include rsconnect code, only used to publish on my end!
library(shiny)
library(rsconnect)
library(ggplot2)

my_ui <- fluidPage(
                   mainPanel("Welcome to my Midwest Graphics Page"),
                   navbarPage("The Midwest in Graphics",
                              tabPanel(
                                "How do People Feel About this Topic?",
                                sidebarPanel("Hashtag", width = 3,
                                             textInput(inputId = "hashtag", "Which hashtag would you like to look up?")
                                             )
                                            
                                )
                    )
)
