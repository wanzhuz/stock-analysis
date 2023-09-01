# Basic Stock Analysis in R

<strong>Task:</strong> Explore the use of packages "quantmod" and "ggplot2" to analyze stock prices and plot their time series

1. Get data from Yahoo Finance with getSymbols() function. I chose Apple (AAPL) for this project from 01-01-2010 to 08-31-2023.
3. Create a time series graph that models Apple's Price Series
4. Calculate moving averages: $$MA^q_t = \frac{1}{q}\sum_{i=0}^{q-1}x_{t-1}$$
5. Find moving averages for a 10-day window and a 30-day window. Note that a larger window corresponds to a smaller moving average responsiveness to price variation
6. We can use technical analysis to determine whether to buy or sell a stock. However, it is more accurate to fit the trends into a regression, minimize residuals, and cross-validate.
7. Calculate returns. For stocks, we use log-returns: $$r_t = ln(1+R_t) = ln(\frac{P_t}{P_{t-1}}) = ln(P_t) - ln(P_{t-1}) \approx R_t$$
8. Plot Returns Series graph
9. Plot Returns Series graph for a specific year. I chose 2020 since it was the start of the pandemic.
