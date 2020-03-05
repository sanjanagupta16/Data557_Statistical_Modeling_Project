
rm(list = ls())

# Load in the raw rda file
df = read.csv("cleaned_df.csv")

hist(df$diff_in_education)
summary(df$diff_in_education)

df$relationship_val <- as.numeric(substr(df$RELATIONSHIP_QUALITY, 2, 2))

summary(lm(relationship_val ~ diff_in_education, data=df))

df$abs_diff_in_education = abs(df$diff_in_education)

hist(df$abs_diff_in_education)
summary(df$abs_diff_in_education)

summary(lm(relationship_val ~ abs_diff_in_education, data=df))



df_different_education <- df[df$abs_diff_in_education!=0.0,]


hist(df_different_education$abs_diff_in_education)
summary(df_different_education$abs_diff_in_education)

summary(lm(relationship_val ~ abs_diff_in_education, data=df_different_education))



df_large_different_education <- df[df$abs_diff_in_education > 4.0,]


hist(df_large_different_education$abs_diff_in_education)
summary(df_large_different_education$abs_diff_in_education)

summary(lm(relationship_val ~ abs_diff_in_education, data=df_large_different_education))



df_vlarge_different_education <- df[df$abs_diff_in_education >= 8.0,]


hist(df_vlarge_different_education$abs_diff_in_education)
summary(df_vlarge_different_education$abs_diff_in_education)

summary(lm(relationship_val ~ abs_diff_in_education, data=df_vlarge_different_education))






fit = lm(relationship_val ~ abs_diff_in_education, data=df)
qqnorm(fit$residuals)
qqline(fit$residuals)



par(mfrow=c(2,2),mar=c(5,4,2,1))
plot(fit)






summary(aov(relationship_val ~ factor(RESPONDENT_YRSED) + factor(PARTNER_YRSED), data=df))
summary(aov(relationship_val ~ factor(RESPONDENT_YRSED)*factor(PARTNER_YRSED), data=df))


## next steps create another column, large diff in education yes/no


df$large_4_diff_in_education <- ifelse(df$abs_diff_in_education >= 4.0, "large", "not large")


summary(aov(relationship_val ~ factor(large_4_diff_in_education), data=df))
