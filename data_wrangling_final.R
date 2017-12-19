library(tidyverse)
library(lubridate)
library(zoo)
Sys.timezone()
#===========================================
#PART I: Reading and formatting data from CSV files
#==========================================

TB3mo<-read.csv('3mo_tb.csv')
oil<-read.csv('crude_oil.csv')
fundsrate<-read.csv('effective_federal_funds_rate.csv')
gold<-read.csv('gold.csv')
loanrate<-read.csv('prime_loans.csv')
exmajor<-read.csv('usex_major.csv')
sp500<-read.csv('^GSPC.csv')

#Select the closing price of each trading day
sp500<-sp500%>%
  mutate(sp500=Close)%>%
  select(Date,sp500)

#Join the tables and filter out dates where data is incomplete
joined <- TB3mo%>%
  left_join(oil,by="DATE")%>%
  left_join(fundsrate,by="DATE")%>%
  left_join(gold,by="DATE")%>%
  left_join(loanrate,by="DATE")%>%
  left_join(exmajor,by="DATE")%>%
  left_join(sp500,by=c("DATE"="Date"))%>%
  filter(!(year(ymd(DATE))<1986))%>%
  filter(!(year(ymd(DATE))==1986&month(ymd(DATE))==1&day(ymd(DATE))==1))%>%
  filter(!(year(ymd(DATE))==2017&month(ymd(DATE))==12&day(ymd(DATE))==1))%>%
  filter(!(year(ymd(DATE))==1986&month(ymd(DATE))==11&day(ymd(DATE))>23))
#some dataset used "." to represent NA values. Convert and remove them. 
is.na(joined) <- joined=="."
joined <- na.omit(joined)

#set all variable data type to numeric
joined$GOLDPMGBD228NLBM<-as.numeric(joined$GOLDPMGBD228NLBM)
joined$DCOILWTICO<-as.numeric(joined$DCOILWTICO)
joined$DTWEXM<-as.numeric(joined$DTWEXM)
joined$DPRIME<-as.numeric(joined$DPRIME)
joined$DTB3<-as.numeric(joined$DTB3)

#=====================================================================
# PART II: Manipulating data to create derivative column
#=====================================================================

joined<-joined%>%
  #rename the columns for better understanding
  rename(three_mo_t_bill=DTB3,crude_oil=DCOILWTICO,
         us_interbank_rate=DFF,gold_price=GOLDPMGBD228NLBM,
         prime_loan_rate=DPRIME,fx_index=DTWEXM)%>%
  #calculates rate of change and first difference where appropriate
  mutate(sp500_returns=(sp500/lag(sp500) - 1),
         sp500_diff=(sp500-lag(sp500)),
         crude_oil_roc=(crude_oil/lag(crude_oil)-1),
         gold_price_roc=(gold_price/lag(gold_price)-1),
         fx_roc=(fx_index/lag(fx_index)-1))

#calculates moving averages 
joined2<-joined%>%
  mutate(sp500_rn20=rollmeanr(joined$sp500, k=20, fill=NA),
         sp500_rn60=rollmeanr(joined$sp500, k=60, fill=NA),
         sp500_rn120=rollmeanr(joined$sp500, k=120, fill=NA),
         fx_rn20=rollmeanr(joined$fx_index, k=20, fill=NA),
         fx_rn60=rollmeanr(joined$fx_index, k=60, fill=NA),
         fx_rn120=rollmeanr(joined$fx_index, k=120, fill=NA),
         oil_rn20=rollmeanr(joined$crude_oil, k=20, fill=NA),
         oil_rn60=rollmeanr(joined$crude_oil, k=60, fill=NA),
         oil_rn120=rollmeanr(joined$crude_oil, k=120, fill=NA),
         interbank_rn20=rollmeanr(joined$us_interbank_rate, k=20, fill=NA),
         interbank_rn60=rollmeanr(joined$us_interbank_rate, k=60, fill=NA),
         interbank_rn120=rollmeanr(joined$us_interbank_rate, k=120, fill=NA),
         gold_rn20=rollmeanr(joined$gold_price, k=20, fill=NA),
         gold_rn60=rollmeanr(joined$gold_price, k=60, fill=NA),
         gold_rn120=rollmeanr(joined$gold_price, k=120, fill=NA),
         tbill_rn20=rollmeanr(joined$three_mo_t_bill, k=20, fill=NA),
         tbill_rn60=rollmeanr(joined$three_mo_t_bill, k=60, fill=NA),
         tbill_rn120=rollmeanr(joined$three_mo_t_bill, k=120, fill=NA))

#remove the rows with incomplete MA data. 
joined2<-joined2[-c(1:120), ] 

#output csv
write.csv(joined2,file="master.csv")
