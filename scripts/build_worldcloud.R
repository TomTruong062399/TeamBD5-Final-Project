library(httr)
library(jsonlite)
library(twitteR)
library(dplyr)
library(RCurl)
library(tm)
library(sentimentr)
library(wordcloud)

source("./api-keys.R")

setup_twitter_oauth(consumer_public, consumer_private, public_key, private_key)

# Build wordcloud
build_wordcloud <- function(key_term) {
  # Sample Tweets
  sample_tweets <- searchTwitter(key_term, lang = "en", n = 300,
                                resultType = "recent")
  sample_tweets_text <- sapply(sample_tweets, function(x) x$getText())

  # Build corpus
  sample_tweets_corpus <- Corpus(VectorSource(sample_tweets_text))

  # Edit Sample Tweets Corpus
  sample_tweets_corpus <- tm_map(sample_tweets_corpus, tolower)
  sample_tweets_corpus <- tm_map(sample_tweets_corpus, removePunctuation)
  sample_tweets_corpus <- tm_map(sample_tweets_corpus, removeWords,
                                stopwords("english"))
  sample_tweets_corpus <- tm_map(sample_tweets_corpus, stripWhitespace)

  # If you want to remove search words because they will obviously be frequent
  sample_tweets_corpus <- tm_map(sample_tweets_corpus, removeWords,
                                c("trump", "president", "america", "hillary"))

  # Create word cloud
  wordcloud(sample_tweets_corpus)
}