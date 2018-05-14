# TeamBD5-Final-Project

## Project Description




###What is the dataset you'll be working with?  Please include background on who collected the data, where you accessed it, and any additional information we should know about how this data came to be.


###Who is your target audience?  Depending on the domain of your data, there may be a variety of audiences interested in using the dataset.  You should hone in on one of these audiences.
Our target audience include, but not limited to, politicians, political news reporters/journalists, and political campaign staffs because they want to and need to understand how themselves or certain politicians are viewed from the public and set their political strategies in accordance. 
For instance, **political campaign staffs** in particular may be interested in using our dataset because they can estimate how their politicians are viewed in general by what words are largely related to the politician and set their election strategies and target their voters accordingly. 

###What does your audience want to learn from your data?  Please list out at least 3 specific questions that your project will answer for your audience.
More specifically, our dataset can give political campaign staffs three important information:
  **Firstly**, it can show them how their own politicians are viewed to the public by looking at what words are generally related to them.
  **Secondly**, our dataset can be used to understand how other, competing, politicians are viewed to the public and set election strategies to precisely address their policies and perhaps move their voters.
  **Thirdly**, political campaign staffs can learn what have been the most popular and/or controversial policies of certain politicians, to understand the American public's interest better and to design more effective political agenda for political campaigns.




## Technical Description
We will be reading this data via Twitter's API
**[Search Tweets](https://developer.twitter.com/en/docs/tweets/search/overview)**
feature. We settled on just using the Standard _(free)_ of this search
API, that only allows a sample size of tweets from the past 7 weeks.
The type of data wrangling we're planning to do is **reshaping the data** to fit our search query.
We don't have any new packages to use for this library yet, we're planning to use the usual ones _(dplyr, ggplot2/plotly)_ until we deeply dive into this API to find **unfamiliar complexities that would require new libraries/packages.** The major challenges we anticipate to have are having **trouble data wrangling and implementing** that data to a Shiny application. Also, knowing how to **utilize the parameters and queries** provided by the API to do what we are planning to do.
