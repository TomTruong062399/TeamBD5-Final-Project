library(httr)
library(jsonlite)
# install.packages("twitteR")
library(twitteR)
library(ggplot2)

source("api-keys.R")

setup_twitter_oauth(consumer_public, consumer_private, public_key, private_key)


hastag_search <- function(term) {
  searched_hash_tage < searchTwitter(term)
  tweets <- twListToDF(search_hash_tage)
  tweets_2 < tweets %>%
    select(text, retweetCount) %>%
    rename(
      "Tweet" = text,
      "Retweet Count" = retweetCount
    )
  return(tweets_2)
}

plot_tweets_retweet_hash_tag <- function(dataset) {
  bar_plot <-ggplot(dataset, aes("Tweet", "Retweet Count"))
  bar_plot + geom_bar(stat = "identity")  
  
  return(bar_plot)
}
