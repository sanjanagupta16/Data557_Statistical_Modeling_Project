#############################
### File Cleaning
#############################

# Remove existing variables
rm(list = ls())

# Load in the raw rda file
load('./30103-0001-Data.rda')

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

#write.csv(df, "cleaned_df.csv")

