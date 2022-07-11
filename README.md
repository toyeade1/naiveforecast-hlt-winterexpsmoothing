# naiveforecast-hlt-winterexpsmoothing

# A souvenir shop at a beach resort town in Queensland, Australia is trying to forecast sales for the next 12 months (year 2002) based on the monthly sales data (in Australian dollars) between 1995 and 2001. 

# The first step is to add the dataset into the R Script. after this we will chart a time series graph in order to see if sales have increased, trends in the previous years, and check for seasonality

# I then split the dataset into training and validation data in order to compare the models accuuracy.    The validation set containing the last 12 months of the dataset (Year 2001)

# The next step is fitting the training data into a seasonal naive forecast model. The results is a Root Mean Squared Error of 9542.3. After this I perform a linear regression model for comparison with trend and season as the predictors. The results of this is an RMSE of 17451.5, which is worse than the maive forcast model. For a final comparision, I use a Holt-Winter prediction model and plot the results, the RMSE is 9893, which is still higher than the naive forecast. I conclude that out of the 3 models, that is the most efficient.
