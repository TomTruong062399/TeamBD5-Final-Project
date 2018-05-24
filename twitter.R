library(httr)
library(jsonlite)
library(twitteR)

source("api-keys.R")

setup_twitter_oauth(consumer_public, consumer_private, public_key, private_key)
tweets <- searchTwitter("USA, Politics, Liberals")