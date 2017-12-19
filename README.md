# Trying to explain the stock market: A look at the correlation between commodity prices, monetary supply and S&P 500 index.
## Final project for STAT231: Data Science Fall 2017 at Amherst College.

The detailed steps to reproducing the results of this project are as followed.

Before following the steps, please make sure to have the **tidyverse**, **lubridate**, **zoo** and **ggplot2** packages installed in your R environment.

**1. Acquiring Data**
Please download the raw data listed below from the corresponding links: \
`1)` effective_federal_funds_rate.csv:\
*Source*: https://fred.stlouisfed.org/series/DFF \
*Explanation*: The federal funds rate is the interest rate at which depository institutions trade federal funds (balances held at Federal Reserve Banks) with each other overnight. \
`2)` usex_major.csv:\
*Source*: https://fred.stlouisfed.org/series/DTWEXM \
*Explanation*: A weighted average of the foreign exchange value of the U.S. dollar against a subset of the broad index currencies that circulate widely outside the country of issue. Major currencies index includes the Euro Area, Canada, Japan, United Kingdom, Switzerland, Australia, and Sweden. \
`3)` 3mo_tb.csv:\
*Source*: https://fred.stlouisfed.org/series/DTB3 \
*Explanation*: The daily interest rates of 3-month Treasury Bills in the secondary market.\
`4)` gold.csv:\
*Source*: https://fred.stlouisfed.org/series/GOLDPMGBD228NLBM \
*Explanation*: Gold price continues to be set twice daily (at 10:30 and 15:00 London GMT) in US dollars by The London Bullion Market Association (LBMA). \
`5)` crude_oil.csv:\
*Source*: https://fred.stlouisfed.org/series/DCOILWTICO \
*Explanation*: Daily crude oil prices. \
`6)` prime_loans.csv:\
*Source*: https://fred.stlouisfed.org/series/DPRIME \
*Explanation*: Rate posted by a majority of top 25 (by assets in domestic offices) insured U.S.-chartered commercial banks. Prime is one of several base rates used by banks to price short-term business loans. \
`7)` sp500.csv: \
*Source*: https://finance.yahoo.com/quote/%5EGSPC/history/ \
*Explanation*: SP500 historical daily data from Yahoo Finance - not the St. Louis Fed this time.

\
**2. Data Tidying and Wrangling**\
Please place the data_wrangling_final.r script in the same directory as the downloaded data above.\
Then, run the script to acquire master.csv, which will be the "master table" used for data analysis and visualization.\
Or, for convenience, the master.csv file could be downloaded from this repo as well.

**3. Running Analysis in R Markdown File**\
Please download the writeup_final.rmd file from this repo and place it in the same directory as master.csv. Make sure to set the working directory to that location.\
Knit the writeup_final.rmd file to acquire a clean version of the write up. Most code chunks are hidden for the sake of succinctness and presentation.

**4. Final Result**\
The final result will be the writeup_final.html file knit from the rmd mentioned above. You will find this file in the same directory where the rmd file is located.
