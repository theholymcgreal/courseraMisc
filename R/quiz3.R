# Q1
library(datasets)
data(iris)
round(tapply(iris$Sepal.Length, iris$Species, mean))
round(mean(iris[which(iris$Species == "virginica"),]$Sepal.Length))

# Q2
apply(iris[ , 1:4], 2, mean)

# Q3
library(datasets)
data(mtcars)

# average mpg by num of cyl
tapply(mtcars$mpg, mtcars$cyl, mean)
with(mtcars, tapply(mpg, cyl, mean))
sapply(split(mtcars$mpg, mtcars$cyl), mean)

# Q4
new <- tapply(mtcars$hp, mtcars$cyl, mean)
round(abs(new[3]-new[1]))
