library(shiny)
library(plotly)
library(rsconnect)
library(ggplot2)

ui <- shinyUI(
  navbarPage(
    "Project Name Here",
    
      tabPanel(
        "How do People Feel About this Topic?",
        sidebarLayout(
        sidebarPanel("Hashtag",
                     width = 3,
                     textInput(inputId = "hashtag", "Which hashtag would you like to look up?")
        ),
        mainPanel(
          plotlyOutput("plot")
        )
        )
      ),
    
      tabPanel(
       "Sample by Term",
      titlePanel("Sample 100 Tweets/Retweets by Term"),
      sidebarLayout(
        sidebarPanel(
          textInput("term",
                    label = "Search for a Term",
                    value = "Trump")
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
          textInput(inputId = "hashtag", "Which hashtag would you like to look up?")
        ),
        mainPanel(
          tableOutput("scripts/twitter.R")
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
