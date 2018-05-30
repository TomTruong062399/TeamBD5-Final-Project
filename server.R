library(shiny)
library(httr)
library(jsonlite)
library(plotly)
library(dplyr)
library(ggplot2)
# install.packages("twitteR")
library(twitteR)

source("api-keys.R")
source('./scripts/key_terms.R')
source("./scripts/SamPartFinalINFO201.R")

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
    output$plot <- renderPlot({
      
      tweet_info <- searchTwitter(paste0("#", "guns"), 30)
      tweet_info_df <- twListToDF(tweet_info)
      
      text <- data_frame(tweet = anti_gun_control_df$text) %>%
        unnest_tokens(word, tweet)
      tweet_score <- text %>%
        inner_join(get_sentiments("afinn"), by = "word") %>%
        count(word, score, sort = TRUE) %>%
        ungroup()
      
      # I split these up for clarity, although they could be combined
      tweet_sentiment <- text %>%
        inner_join(get_sentiments("nrc"), by = "word") %>%
        count(sentiment, sort = TRUE) %>%
        ungroup() %>%
        rename(word = sentiment)
      
      binary_sentiment <- tweet_sentiment %>%
        inner_join(get_sentiments("bing"), by = "word") %>%
        ungroup()
      
      total_score <- tweet_score$score * tweet_score$n
      
      
      # I would like to point out that it was NOT easy to get those colors right
      positivity_plot <- ggplot(data = tweet_score, aes(x=factor(word), y = total_score)) +
        geom_bar(aes(fill = total_score < 0), stat = "identity") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        scale_fill_manual(guide = FALSE, breaks = c(TRUE, FALSE), values=c("green", "red")) +
        labs(x = "Most Common Words in Tweets",
             y = "Positivity Score",
             title = "Positivity of Tweets",
             fill = "Positivity")
      
      # Using only 3 through 8 since 'positive' and 'negative are by
      # far the most popular sentiments, although they cannot be used
      sentiment <- ggplot(binary_sentiment[3:8,], aes(x = rev(factor(word, levels = unique(word))), y = n)) +
        geom_bar(stat= "identity", aes(fill = sentiment)) +
        coord_flip() +
        labs(x = "Most Common Emotions",
             y = "Frequency",
             title = "Emotions Conveyed by Tweets",
             fill = "Positivity")
      sentiment
    })
  }
)