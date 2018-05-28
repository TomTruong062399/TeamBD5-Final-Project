library(httr)
library(jsonlite)
library(twitteR)

source("api-keys.R")

setup_twitter_oauth(consumer_public, consumer_private, public_key, private_key)

conservative_tweets <- searchTwitter("#Conservatives") 
liberal_tweets <- searchTwitter("#Liberals")
# Use something like this for data: liberal_df <- twListToDF(liberal_tweets)


gun_control_tweets <- searchTwitter("#gun control")
anti_gun_control_tweets <- searchTwitter("#noguncontrol")

abortion_tweets <- searchTwitter("#abortion")
anti_abortion_tweets <- searchTwitter("#noabortion")
