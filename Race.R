# Give data a friendly name
df <- da30103.0001
# look at column names
names(df)

keeps <- c('RESPONDENT_YRSED',# Approx Respondent yrs education based on ppeduc, first demographic survey
           'PARTNER_YRSED',   #Partner yrs education based on q10
           'PPINCIMP',        #Binned - total combined household income
           'PPWORK',          #employment
           'QFLAG',           # does person have a partner?
           'PAPGLB_STATUS',   #(gay, lesbian, or bisexual)
           'PPMARIT',         # marital status
           'PPGENDER',        # gender
           'Q4',              #( is partner female or male) 
           'Q5',              #(is partner same gender)
           'Q23',             # between you and [partner_name], who earned more income in 2008
           'PPETHM',          # race/ethnicity
           'Q6B',             # race of partner
           'RESPONDENT_RACE',
           'PARTNER_RACE',
           'RELATIONSHIP_QUALITY' # relationship quality, based on q34, higher number is better
)

# store as new df
df <- df[keeps]

# only keep the partnered people
df <- df[df$QFLAG=='(1) partnered',]
# add a new column to track difference in education
df['diff_in_education'] = df$RESPONDENT_YRSED - df$PARTNER_YRSED
# add boolean to track difference in race
df['diff_in_race'] = ifelse(df$RESPONDENT_RACE == df$PARTNER_RACE, 0, 1)
# add boolean to track difference in income
df['diff_in_income'] = ifelse(df$Q23 == '(2) we earned about the same amount', 0, 1)


## use the table function to see how distributed key variables are
hist(df$diff_in_education)
hist(df$diff_in_race)
hist(df$diff_in_income)


## look at the  NA's in all columns
for(i in 1:dim(df)[2])
{
  print(paste(names(df)[i], length(which(is.na(df[,i])))))
}


#preparing race dataset
race <- df[ c('RESPONDENT_RACE',
              'PARTNER_RACE',
              'RELATIONSHIP_QUALITY',
              'diff_in_race')]
race_clean <- race[complete.cases(race),]
race_clean$relationship_val <- as.numeric(substr(race_clean$RELATIONSHIP_QUALITY, 2, 2))
race_clean$couple_race <- paste(race_clean$RESPONDENT_RACE, race_clean$PARTNER_RACE)
race_clean

same <- subset(race_clean, diff_in_race==0)
mixed <- subset(race_clean, diff_in_race==1)

# testing dataset
var(same$relationship_val)
var(mixed$relationship_val)
nrow(mixed)
nrow(same)


#Question 1: are same race couples happier than mixed race couples?
# TEST - H0:SAME =< MIXED, H1: SAME > MIXED
# no sampling: same(2476), mixed(509)
t.test(same$relationship_val, mixed$relationship_val,  var.equal=FALSE, alternative="greater")$p.value



# Question 2
# Are all same race couples equally happy? 
#help plotting same race couple distribution
library(ggplot2)
# Grouped
ggplot(same, aes(couple_race)) + 
  geom_bar() + coord_flip() 

summary(aov(relationship_val ~ factor(couple_race), data=same))['1Pr(>F)']


# Question 3
# Which same race couple is happier?

# Compare one race with everyone else
list_couple_race = unique(same$couple_race) 
k=0
pvalues_list = c()
for(i in list_couple_race){
  print("")
  specific_race<- subset(same, couple_race==i)$relationship_val 
  #list_couple_race= list_couple_race[list_couple_race != i] 
  data2<- subset(same, couple_race!=i)
  p_value = t.test(specific_race, data2$relationship_val, var.equal=FALSE, alternative="greater")$p.value
  print(paste("pairwise", i, sep=" "))
  print(p_value)
  
  pvalues_list=c(pvalues_list, p_value)
  k=k+1
}


# Compare every race with each other
list_couple_race = unique(same$couple_race) 
k=0
pvalues_list = c()
for(i in list_couple_race){
  specific_race<- subset(same, couple_race==i)$relationship_val 
  #list_couple_race= list_couple_race[list_couple_race != i] 
  for(j in list_couple_race){
    data2<- subset(same, couple_race==j)$relationship_val
    p_value = t.test(specific_race, data2, var.equal=FALSE, alternative="greater")$p.value 
    print(paste("pairwise", i, j, sep=" "))
    print(p_value)
    
    pvalues_list=c(pvalues_list, p_value)
    k=k+1
  }
}


# Power Calculation
power = 0.8
beta = 1 - power 
alpha=0.05
Z1 = qnorm(1-beta)
Z2 = qnorm(1-alpha/2)

list_couple_race = unique(same$couple_race) 
k=0
for(i in list_couple_race){
  specific_race<- subset(same, couple_race==i)$relationship_val 
  for(j in list_couple_race){
    data2<- subset(same, couple_race==j)$relationship_val
    var_new = var(specific_race) 
    var_2 = var(data2) 
    var_joint = var_new + var_2
    delta = mean(specific_race) - mean(data2)
    n=(var_joint* ((Z1+Z2)**2) )/(delta**2) 
    print(paste(i, j, n, sep=","))
    k=k+1
  }
}


