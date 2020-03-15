################################################
### Analyze Income on Relationship Quality
################################################

# load stringr package
#library(stringr)
#library(tidyr)
#library(ggplot2)

rm(list=ls())
# Topic 2: How does income/income disparity affect relationship outcomes over time? And how does total income affect relationship length?

source('clean_data_file.R')

#remove NAs from the relationship quality column
df <- df[is.na(df$RELATIONSHIP_QUALITY)==FALSE,]

# clean up the income column - grab the number associated with each category
df$income_val <- as.numeric(substr(df$PPINCIMP, 2, 3))

# clean up the relationship quality column - grab the number associated with each category
df$relationship_val <- as.numeric(substr(df$RELATIONSHIP_QUALITY, 2, 2))


#########################
### T-Test
#########################
#   Hypothesis testing: Our null hypothesis is that combined income of couples of greater than $75,000 (chosen due to factors explained here: https://www.huffpost.com/entry/map-happiness-benchmark_n_5592194) has no effect on relationship length/quality. We will perform the test via a large sample Z-test or t-test since our sample size is sufficiently large for both. We will create a calculated field for combined income that adds Partner 1 Income to Partner 2 incomes.


# create a boolean to track if couples make $75,000 or more
df$income_greater_than_75k <- as.numeric(ifelse(df$income_val >= 14, 1, 0))

# split into two groups
more.than.75k.group <- df$relationship_val[df$income_greater_than_75k == 1]
less.than.75k.group <- df$relationship_val[df$income_greater_than_75k == 0]

# look at the results of the test - highly significant
t.test(more.than.75k.group, less.than.75k.group, var.equal = FALSE)

# linear model on a two variable test is equivalent to a two sample t-test with equal variance
summary(lm(relationship_val ~ income_greater_than_75k, data = df))

#####################
## Linear Models
#####################
# Linear regression: we will create a linear regression model using income as the predictor variable and relationship length/quality as the outcome variable and examine the strength of the income coefficient, as well as the correlation between income and relationship length.



Linearity – we draw a scatter plot of residuals and y values. Y values are taken on the vertical y axis, and standardized residuals (SPSS calls them ZRESID) are then plotted on the horizontal x axis. If the scatter plot follows a linear pattern (i.e. not a curvilinear pattern) that shows that linearity assumption is met.  

Independence – we worry about this when we have longitudinal dataset. Longitudinal dataset is one where we collect observations from the same entity over time, for instance stock price data – here we collect price info on the same stock i.e. same entity over time.

We generally have two types of data: cross sectional and longitudinal. Cross -sectional datasets are those where we collect data on entities only once. For example we collect IQ and GPA information from the students at any one given time (think: camera snap shot)

Longitudinal data set is one where we collect GPA information from the same student over time (think: video).

In cross sectional datasets we do not need to worry about Independence assumption. It is “assumed” to be met.

Normality: we draw a histogram of the residuals, and then examine the normality of the residuals. If the residuals are not skewed, that means that the assumption is satisfied.


Even though is slightly skewed, but it is not hugely deviated from being a normal distribution. We can say that this distribution satisfies the normality assumption.
Equality of variance: We look at the scatter plot which we drew for linearity (see above) – i.e. y on the vertical axis, and the ZRESID (standardized residuals) on the x axis. If the residuals do not fan out in a triangular fashion that means that the equal variance assumption is met.



model3 <- summary(lm(fev ~ age+male+ht+smoke, data=df.fev))
model3$coefficients

hist(model3$residuals,main="")

x <- model3$residuals
h<-hist(x, xlab="Model 3 Residuals", ylim=c(0,350),
        main="")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="red", lwd=2)

plot(model2)

qqnorm(model2$residuals)
qqline(model2$residuals)

plot(relationship_val ~ diff_in_income, data=df)

model3 <- lm(fev ~ age+male+ht+smoke, data=df.fev)
plot(model3$fitted.values, model3$residuals)

model4 <- summary(glm(diff_in_income ~ relationship_val, data=df, family = binomial))
exp(model4$coefficients['relationship_val', 'Estimate'])


scatter.smooth(model3$fitted.values, abs(model3$residuals))

# linear model looking at diff_in_income
model2 <- summary(lm(relationship_val ~ diff_in_income, data = df))
model2

hist(model2$residuals,main="")

x <- model2$residuals
h<-hist(x, xlab="Model 2 Residuals", ylim=c(0,1500),xlim=c(-3,2),
        main="")
xfit<-seq(min(x),2,length=50)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="red", lwd=2)

plot(model2$fitted.values, model2$residuals)


# linear model looking at income val
summary(aov(relationship_val ~ factor(income_val), data = df))

# looking at both together
summary(lm(relationship_val ~ diff_in_income+factor(income_val), data=df))$coef

x <- model6$residuals
h<-hist(x, xlab="Model 6 Residuals", ylim=c(0,1500),xlim=c(-2,2),
        main="")
xfit<-seq(min(x),2,length=50)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="red", lwd=2)


x <- more.than.75k.group
y <- less.than.75k.group
hist(x)
hist(y, add=T)


data = df$income_greater_than_75k
mu_0 = mean(data)
mu_1 = mu_0 *.8
numerator = sd(pre)^2 * (qnorm(.9) + qnorm(1-.05/2)^2)
denominator = (mu_0 - mu_1)^2
n = numerator/denominator
n
