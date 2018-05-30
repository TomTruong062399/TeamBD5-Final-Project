library(shiny)
library(plotly)
library(tidytext)
library(ggpubr)

ui <- shinyUI(
  navbarPage(
    "Final Project",
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
          textInput("hashtag",
            label = "Search for a Term",
            value = "Trump"
          )
        ),
        mainPanel(
          plotOutput("plot"),
          plotOutput("plot2")
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
    ),
    tabPanel(
      "Word Cloud",
      titlePanel("Trends in Words That are Used Most Commonly in Relation
                 to a Politician"),
      sidebarLayout(
        sidebarPanel(
          textInput("Politician",
            label = "Enter Politician Name",
            value = "Trump"
          ),
          sliderInput("Number", "Select Number of Tweets",
            min = 50, max = 500, value = 275
          ),
          radioButtons("lang", "Select Language", c(
            "English" = "en",
            "Spanish" = "es"
          )),
          submitButton(text = "Run")
        ),
        mainPanel(
          plotOutput("pol_wordcloud")
        )
      )
    )
  )
)
