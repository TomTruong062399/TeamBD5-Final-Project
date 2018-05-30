library(shiny)
library(httr)
library(jsonlite)
library(plotly)
# install.packages("twitteR")
library(twitteR)

source("api-keys.R")
source('./scripts/key_terms.R')

setup_twitter_oauth(consumer_public, consumer_private, public_key, private_key)

shinyServer(
  function(input, output) { 
    output$key_tweets <- renderTable({ 
      return(term_search(input$term))   
    })
    tweets <- reactive({
      popular <- return(term_top_5(input$top_5, input$quantity))
    })
    output$tweets_plot <- renderPlotly({
      return(plot_tweets(tweets()))   
    })
    output$tweets_tbl <- renderTable({
      tweets()[, c("Twitter Handle", "Tweet", "Number of Retweets")]
    })
  }
)