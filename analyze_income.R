################################################
### Analyze Income on Relationship Quality
################################################

# load stringr package
library(stringr)
library(tidyr)
library(ggplot2)

# Topic 2: How does income/income disparity affect relationship outcomes over time? And how does total income affect relationship length?




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

# linear model on a two variable test is equivalent to a two sample t-test
summary(lm(relationship_val ~ income_greater_than_75k, data = df))


#####################
## Linear Models
#####################
# Linear regression: we will create a linear regression model using income as the predictor variable and relationship length/quality as the outcome variable and examine the strength of the income coefficient, as well as the correlation between income and relationship length.


# linear model looking at diff_in_income
summary(lm(relationship_val ~ diff_in_income, data = df))

# linear model looking at income val
summary(lm(relationship_val ~ factor(income_val), data = df))

# looking at both together
summary(lm(relationship_val ~ diff_in_income+factor(income_val), data=df))$coef

