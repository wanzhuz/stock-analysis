rm(list=ls())
install.packages("quantmod")
library(quantmod)
library(ggplot2)

apple = getSymbols("AAPL", src="yahoo", from="2010-01-01", to="2023-08-31", auto.assign=FALSE)
head(apple)
tail(apple)
summary(apple)
str(apple)

# create time series graph
ggplot(apple, aes(x=index(apple), y=apple[,6])) + 
  geom_line(color="darkgreen") + 
  ggtitle("Apple Prices Series") + 
  xlab("Date") + ylab("Price") + 
  theme(plot.title=element_text(hjust=0.5)) + 
  scale_x_date(date_labels="%b %Y", date_breaks="1 year")

# calculate moving averages
# MA^q_t = (1/q)summ(i=0 to q-1) of (x_(t-1))
# bigger day window corresponds to smaller MA responsiveness to price var
# smaller day window corresponds to bigger MA responsiveness to price var

apple_mm = subset(apple, index(apple) >= "2016-01-01")

# 10 day window
apple_mm10 = rollmean(apple_mm[,6], 10, fill=list(NA, NULL, NA), align="right")
apple_mm30 = rollmean(apple_mm[,6], 30, fill=list(NA, NULL, NA), align="right")

apple_mm$mm10 = coredata(apple_mm10)
apple_mm$mm30 = coredata(apple_mm30)

# when short term MA cross long term upwards --> BUY
# when short term MA cross long term downwards --> SELL

ggplot(apple_mm, aes(x=index(apple_mm))) +
  geom_line(aes(y=apple_mm[,6], color="APPLE")) +
  ggtitle("Apple Prices Series") +
  geom_line(aes(y=apple_mm$mm10, color="MM10")) +
  geom_line(aes(y=apple_mm$mm30, color="MM30")) +
  xlab("Date") + ylab("Price") +
  theme(plot.title=element_text(hjust=0.5), panel.border=element_blank()) +
  scale_x_date(date_labels="%b %Y", date_breaks="6 months") +
  scale_color_manual("Series", values=c("APPLE"="red4", "MM10"="cyan4", "MM30"="grey40"))
  
# returns
# calculate log-return of stock
apple_ret = diff(log(apple[,6])) # diff calculates all values in any vector
apple_ret = apple_ret[-1,]

# quantmod functions
Op(apple) # opening values
Cl(apple) # closing values
Ad(apple) # adjusted values
Hi(apple) # max price
Lo(apple) # min price
Vo(apple) # volume of transactions

dailyReturn(apple)
weeklyReturn(apple)
monthlyReturn(apple)
quarterlyReturn(apple)
yearlyReturn(apple)

summary(apple_ret)
sd(apple_ret)

# returns over time
ggplot(apple_ret, aes(x=index(apple_ret), y=apple_ret)) +
  geom_line(color="lightblue4") +
  ggtitle("Apple Returns Series") +
  xlab("Date") + ylab("Return") +
  theme(plot.title=element_text(hjust=0.5)) +
  scale_x_date(date_labels="%b %Y", date_breaks="1 year")

# look at returns in 2020
apple_ret20 = subset(apple_ret, index(apple_ret) > "2020-01-01" & index(apple_ret) < "2021-01-01")
ggplot(apple_ret20, aes(x=index(apple_ret20), y=apple_ret20)) +
  geom_line(color="lightblue4") +
  ggtitle("Apple Return Series in 2020") +
  xlab("Date") + ylab("Return") +
  theme(plot.title=element_text(hjust=0.5)) +
  scale_x_date(date_labels="%b %Y", date_breaks="1 month")

summary(apple_ret20)
sd(apple_ret20)






