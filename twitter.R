library(httr)
library(jsonlite)
library(twitteR)

source("api-keys.R")

setup_twitter_oauth(consumer_public, consumer_private, public_key, private_key)

# Grabbed the required 
conservative_tweets <- searchTwitter("#Conservatives") 
liberal_tweets <- searchTwitter("#Liberals")
gun_control_tweets <- searchTwitter("#gun control")
anti_gun_control_tweets <- searchTwitter("#noguncontrol")
abortion_tweets <- searchTwitter("#abortion")
anti_abortion_tweets <- searchTwitter("#noabortion")

# Converted to Data Frames
liberal_df <- twListToDF(liberal_tweets)
conservative_df <- twListToDF(conservative_tweets)
gun_control_df <- twListToDF(gun_control_tweets)
anti_gun_control_df <-twListToDF(anti_gun_control_tweets)
abortion_df <- twListToDF(abortion_tweets)
anti_abortion_df <- twListToDF(anti_abortion_tweets)


# All data merged
all_data_merged <- rbind(liberal_df, conservative_df, gun_control_df, anti_gun_control_df, abortion_df, anti_abortion_df)