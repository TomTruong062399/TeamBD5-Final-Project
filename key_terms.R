library(httr)
library(jsonlite)
# install.packages("twitteR")
library(twitteR)

term_search <- function(key_term, quantity) {
  searched_tweets <- searchTwitter(key_term,
                                   n = quantity) 
  tweets <- twListToDF(searched_tweets)
  tweets_tbl <- select(tweets, screenName, text)
  return(tweets_tbl)
}