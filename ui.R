library(shiny)
library(plotly)
library(tidytext)
library(ggpubr)

ui <- shinyUI(
  navbarPage(
    "Project Name Here",
    
    tabPanel(
      "Sample by Term",
      titlePanel("Sample 100 Tweets/Retweets by Term"),
      sidebarLayout(
        sidebarPanel(
          textInput("term",
                    label = "Search for a Term",
                    value = "Trump"
          )
        ),
        mainPanel(
          tableOutput("key_tweets")
        )
      )
      ),
      
      tabPanel(
        "HashTag",
        titlePanel("HashTag"),
        sidebarLayout(
          sidebarPanel(
            width = 3,
<<<<<<< HEAD
            textInput("hashtag", 
                      label = "Search for Term", 
                      value = "#Trump")
          ),
          mainPanel(
            plotOutput("plot")
            
=======
            textInput(inputId = "hashtag", "Which hashtag would you like to look up?")
          ),
          mainPanel(
            tableOutput("scripts/twitter.R")
>>>>>>> 0ac1be2422f7a058d61677a461dc34fad9b40a8b
          )
        )
      ),
      tabPanel(
        "Most Retweeted",
        titlePanel("Top 5 Tweets/Retweets by Retweets"),
        sidebarLayout(
          sidebarPanel(
            textInput("top_5",
                      label = "Top 5 Tweets/Retweets from a Random Sample",
                      value = "Trump"
            ),
            sliderInput("quantity",
                        label = "Select of Sample Size",
                        min = 1,
                        max = 1000,
                        value = 500,
                        ticks = TRUE,
                        animate = FALSE
            )
          ),
          mainPanel(
            plotlyOutput("tweets_plot"),
            tableOutput("tweets_tbl")
          )
        )
      )
    )
  )
