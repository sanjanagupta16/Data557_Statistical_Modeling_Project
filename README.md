## Preliminary Proposal

Group: Sanjana Gupta, Natasha Halfin, Andreia Sodre Nichols, Karl Stavem, and Maggie Weatherly

Romantic relationships are ubiquitous in human life. In Western culture, monogamous relationships and marriage are seen as the norm. However, a commonly shared statistic is that 50% of marriages end in divorce. Hence, the question: what makes relationships successful? What features are highly correlated with long-lasting relationships? 

We are interested in investigating the following questions related to this topic:
How does race affect relationship length? Do mixed race couples stay together longer than same race couples or vice versa?
How does income/income disparity affect relationship outcomes over time? And how does total income affect relationship length?
How does education level affect relationships? Do big disparities in education affect the length of a relationship? 

## Description of data
We propose to use the dataset “How Couples Meet and Stay Together (HCMST)”. The dataset was collected from 2009 to 2015 by surveying 4,002 American respondents over five waves. Response to Wave 1 (main survey), in 2009,  was 71 percent. Response to Wave 2 (follow-up survey) one year later was 84 percent. Response to Wave 3 (follow-up survey) one year later was 72.9 percent. Response to Wave 4 (follow-up survey), in 2013, was 60 percent. The response rate to Wave 5 (follow-up survey), in 2015, was 46%. In total, the dataset has 4,002 observations with 534 features that include information such as marital status, sexuality, education level, income, and geographic location.

Both heterosexual and LGBTQ individuals were surveyed. Additionally, relationship status and marital status were recorded in each wave, so we can examine patterns over time. We currently have access to the public use portion of the dataset. Each record represents a survey response from one individual.

## Assumptions
Survey respondents were recruited by random digit dial phone survey; therefore the survey population was randomly selected. However, we cannot say with confidence that the respondents are representative of the broader US population. In fact, the study oversampled LGBTQ populations to attempt to balance the study population. Furthermore, we are assuming that survey responses are truthful, although the data is ultimately self-reported and may not be entirely accurate.

Data source: 
https://www.icpsr.umich.edu/icpsrweb/ICPSR/studies/30103?q=&paging.rows=25&sortBy=10
Rosenfeld, Michael J., Thomas, Reuben J., and Falcon, Maja. How Couples Meet and Stay Together (HCMST), Wave 1 2009, Wave 2 2010, Wave 3 2011, Wave 4 2013, Wave 5 2015, United States. Ann Arbor, MI: Inter-university Consortium for Political and Social Research [distributor], 2016-03-18. https://doi.org/10.3886/ICPSR30103.v8


## Analysis Methods
For our questions above, we plan to apply a combination of analysis methods: hypothesis testing, linear regression, and ANOVA. Our primary metric of relationship success is length of relationship. Since ¼ of the survey respondents are not coupled, we will exclude these data points to focus only on partnered respondents.

Our plan for analysis is as follows:

Independent variables:
Partner 1 Race
Partner 2 Race
Partner 1 Income
Partner 2 Income
Partner 1 Education Years
Partner 2 Education Years

#### Dependent variables
Length of relationship (for couples who broke up over the course of the study)
Relationship quality (for couples who were still together by the end of the study)

* Topic 1: How does race affect relationship length? Do mixed race couples stay together longer than same race couples or vice versa?
Hypothesis testing: Our null hypothesis is that mixed race couples have the same relationship length/quality as same race couples. We will perform the test via a 2-sample t-test or Z-test since our sample size is sufficiently large for both. We will compare Partner 1 Race to Partner 2 Race and create a calculated field that indicates if they are the same race or not.
ANOVA:  If our hypothesis test leads to a conclusion that mixed race couples have longer relationship lengths/higher quality, we will investigate the follow-up question: does the specific combination of race have an effect on relationship length? Since race is a categorical variable, it makes sense to apply this method for this question. 

* Topic 2: How does income/income disparity affect relationship outcomes over time? And how does total income affect relationship length?
Hypothesis testing: Our null hypothesis is that combined income of couples of greater than $75,000 (chosen due to factors explained here: https://www.huffpost.com/entry/map-happiness-benchmark_n_5592194) has no effect on relationship length/quality. We will perform the test via a large sample Z-test or  t-test since our sample size is sufficiently large for both. We will create a calculated field for combined income that adds Partner 1 Income to Partner 2 incomes.
Linear regression: we will create a linear regression model using income as the predictor variable and relationship length/quality as the outcome variable and examine the strength of the income coefficient, as well as the correlation between income and relationship length.

* Topic 3: How does education level affect relationships? Do big disparities in education affect the length of a relationship? 
Hypothesis testing: Our null hypothesis is that same education levels results in longer relationships/higher quality relationships. We will perform the test via a 2-sample t-test to determine if a difference in education affects the length of the relationship, and we will control for all other variables. We will create a calculated field for Partner 1 Education - Partner 2 Education.
Linear regression: we will create a linear regression model using education difference (Partner 1 Education - Partner 2 Education) as the predictor variable and relationship length/quality as the outcome variable and examine the strength of the education difference coefficient, as well as the correlation between education difference and relationship length/quality.
