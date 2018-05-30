library(shiny)
library(httr)
library(jsonlite)
# install.packages("twitteR")
library(twitteR)

source("api-keys.R")
source('key_terms.R')

setup_twitter_oauth(consumer_public, consumer_private, public_key, private_key)

shinyServer(
  function(input, output) { 
    output$key_tweets <- renderTable({ 
      return(term_search(input$term, input$quantity))   
    }) 
  }
)