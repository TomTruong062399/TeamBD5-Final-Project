library(httr)
library(jsonlite)
library(twitteR)

source("api-keys.R")

setup_twitter_oauth(consumer_public, consumer_private, public_key, private_key)

conservative_tweets <- searchTwitter("#Conservatives", n = 100) 
liberal_tweets <- searchTwitter("#Liberals", n = 100)

