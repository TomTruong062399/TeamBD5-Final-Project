library(shiny)
library(httr)
library(jsonlite)
library(plotly)
library(dplyr)
library(ggplot2)
library(twitteR)
library(RCurl)
library(tm)
library(wordcloud)

source("api-keys.R")
source("./scripts/key_terms.R")

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
      tweet_info <- searchTwitter(paste0("#", input$hashtag), 50)
      tweet_info_df <- twListToDF(tweet_info)

      text <- data_frame(tweet = tweet_info_df$text) %>%
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
        ungroup() %>%
        arrange(n)


   is.data.frame(binary_sentiment)
      total_score <- tweet_score$score * tweet_score$n

      # I would like to point out that it was NOT easy to get those colors right
      positivity_plot <- ggplot(data = tweet_score, aes(x = factor(word),
                                                        y = total_score)) +
        geom_bar(aes(fill = total_score < 0), stat = "identity") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        scale_fill_manual(guide = FALSE, breaks = c(TRUE, FALSE),
                          values = c("green", "red")) +
        labs(
          x = "Most Common Words in Tweets",
          y = "Positivity Score",
          title = "Positivity of Tweets",
          fill = "Positivity"
        )

      # Using only 3 through 8 since 'positive' and 'negative are by
      # far the most popular sentiments, although they cannot be used

      sentiment <- ggplot(binary_sentiment, aes(x = factor(word,
                                              levels = unique(word)), y = n)) +
        geom_bar(stat = "identity", aes(fill = factor(sentiment))) +
        coord_flip() +
        labs(
          x = "Most Common Emotions",
          y = "Frequency",
          title = "Emotions Conveyed by Tweets",
          fill = "Positivity"
        )

      ggarrange(sentiment, positivity_plot,
        labels = c("A", "B"),
        ncol = 2, nrow = 1
      )
    })

    output$plot2 <- renderPlot({
      search <- searchTwitter(input$hashtag)
      popular_tweets <- twListToDF(search)
      bar_stuff <- popular_tweets %>%
        select(screenName, retweetCount)

      bar_plot <- ggplot(bar_stuff, aes(screenName, retweetCount))
      bar_plot + geom_bar(stat = "identity", fill = "#FF6666") +
        xlab("Usernames") +
        ylab("Retweet Count") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
    })

    output$pol_wordcloud <- renderPlot({
      sample_tweets <- searchTwitter(input$Politician,
                                     lang = input$lang,
                                     n = input$Number,
                                     resultType = "recent"
      )
      Sample_tweets_text <- sapply(sample_tweets, function(x) x$getText())
      Sample_tweets_text2 <- iconv(
        Sample_tweets_text, "latin1",
        "ASCII//TRANSLIT"
      )
      Sample_tweets_text3 <- iconv(Sample_tweets_text2, to = "ASCII//TRANSLIT")
      Sample_tweets_corpus <- Corpus(VectorSource(Sample_tweets_text3))
      Sample_tweets_corpus <- tm_map(Sample_tweets_corpus, tolower)
      Sample_tweets_corpus <- tm_map(Sample_tweets_corpus, removePunctuation)
      Sample_tweets_corpus <- tm_map(
        Sample_tweets_corpus, removeWords,
        stopwords(input$lang)
      )
      Sample_tweets_corpus <- tm_map(Sample_tweets_corpus, stripWhitespace)

      # Filter commonly used words for more accurate representation
      Sample_tweets_corpus <- tm_map(
        Sample_tweets_corpus, removeWords,
        c(
          "trump", "donald", "president", "america",
          "hillary", "americans", "think", "says",
          "call", "know", "will", "claimed", "even",
          "every", "amp", "said", "voted", "rt",
          "realdonaldtrump", "therealroseanne",
          "now", "made", "let", "like", "just",
          "yesterday", "makes", "knows", "someone",
          "called", "comments", "got", "one", "many",
          "knew", "knows"
        )
      )
      pal2 <- brewer.pal(8, "Dark2")
      wordcloud(Sample_tweets_corpus,
                random.order = FALSE,
                colors = pal2
      )
    })
  }
)