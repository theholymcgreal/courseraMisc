# Week 3

# lapply


# anonymous function
x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
lapply(x, function(elt) elt[,1])        #extracts first column of matrix

# sapply vs lapply
x <- list(a= 1:4, b = rnorm(10), c = rnorm(20,1), d = rnorm(100,5))
lapply(x, mean)

sapply(x, mean)         # returns vector of 4 numbers

# apply
x <- matrix(rnorm(200), 20, 10)         # matrix has 20 rows, 10 columns
apply(x, 2, mean)                       # margin 2 = collapse rows and keep columns

apply(x, 1, sum)        # margin 1 = collapse rows and keep columns 

x <- matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs = c(0.25, 0.75))    # preserves rows and calcs 25 and 75 percentile

# apply array
a <- array(rnorm(2 *2 *10), c(2, 2, 10))
apply(a, c(1, 2), mean)         # keep 1st and 2nd dimension, collapse 3rd
rowMeans(a, dims = 2)

#mapply
mapply(rep, 1:4, 4:1)   #applies function to multiple set of arguments



noise <- function(n, mean, sd) {
        rnorm(n, mean, sd)
}
noise(5, 1, 2)
noise(1:5, 1:5, 2)

mapply(noise, 1:5, 1:5, 2)      # instantly vectorize function that doesnt allow for vector arguments
# same as
list(noise(1, 1, 2), noise(2, 2, 2), noise(3, 3, 2), noise(4, 4, 2), noise(5, 5, 2))


# tapply
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
f

tapply(x, f, mean)
tapply(x, f, mean, simplify = F) # get back a list with 3 elements and each element is the mean of the subgroup
tapply(x, f, range)  # gives back min and max within subset x


# split
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
split(x , f)  # split returns list back

lapply(split(x, f), mean)  # split and then lapply function over it
                                # nor necessary, can use tapply to do exact same thing

library(datasets)
head(airquality)

s <- split(airquality, airquality$Month)   # split by month, not a factor variable (coerced)
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))   #lappy anonymous function colMeans for each month
                # returns list of each element of length 3, mean from within each month
                # some NA values mean unable to calc mean
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")])  # sapply simplifies result into matrix

sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE))    # removes NAs

# splitting on more than one level
x <- rnorm(10)
f1 <- gl(2, 5)  # factor with 2 levels, each repeated 5 times
f2 <- gl(5, 2)  # factor with 5 levels, each repeated 2 times
f1

f2

interaction(f1, f2)  # combines all levels of first one with all levels of second

str(split(x, list(f1, f2))) # dont need to use interaction function, automatically called by passing list

str(split(x, list(f1, f2), drop = TRUE))  # drops empyt levels, handy when combining multiple factors


# diagnostic
log(-1)  # warning

printmessage <- function(x) {
        if(x > 0)
                print("x is greater than zero")
        else
                print("x is less than or equal to zero")
        invisible(x)
}
printmessage(1)
printmessage(NA)  # error

printmessage2 <- function(x) {
        if(is.na(x))
                print("x is a missing value")
        else if(x >0)
                print("x is greater than zero")
        else
                print("x is less than or equal to zero")
        invisible(x)
}
x <- log(-1)  # warning
printmessage2(x)  # no error, unexpected

# using debugging tools
# traceback, where the error occurs, useful for comm over email by printing out traceback
# must call traceback immediately after error occurs
mean(h)  # mean of something that doesn't exist
traceback()  # where the error occurs

lm(y -x)  # can;t find actual values of y and x
traceback()

# debug
debug(lm)
lm(y - x)

# recover
options(error = recover)   # function call stack after error occurs
read.csv("nosuchfile")






                                                                          