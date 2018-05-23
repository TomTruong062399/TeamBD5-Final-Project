library(httr)
library(jsonlite)

source("api-keys.R")

address <- "10309 24th Ave SW"

base_uri <- "https://api.twitter.com/1.1"
endpoint <- "/search/tweets.json"
query_params <- "/oauth2/token"

twitter_response <- GET(paste0(base_uri, endpoint))
twitter_content <- content(twitter_response, "text")
twitter_data <- fromJSON(twitter_content)