download.file("https://dl.dropboxusercontent.com/u/7710864/data/ravensData.rda"
              , destfile="./data/ravensData.rda", method="curl")
load("./data/ravensData.rda")
head(ravensData)

# linear model
lmRavens <- lm(ravensData$ravenWinNum ~ ravensData$ravenScore)
summary(lmRavens)$coef

# odds
# model the probability the ravens win
logRegRavens <- glm(ravensData$ravenWinNum ~ ravensData$ravenScore, family="binomial")
summary(logRegRavens)
plot(ravensData$ravenScore, logRegRavens$fitted, pch=19, col="blue", xlab="Score", ylab="Prob Ravens Win")
exp(logRegRavens$coeff)
exp(confint(logRegRavens))
anova(logRegRavens,test="Chisq")
