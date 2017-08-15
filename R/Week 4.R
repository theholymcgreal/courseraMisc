# str function
library(datasets)
head(airquality)
str(airquality)

# generating random numbers
# Normal distribution
str(dnorm)
str(pnorm)
str(qnorm)
str(rnorm)

x <- rnorm(10)  # mean = 0, SD = 1
x
x <- rnorm(10, 20, 2)  # mean = 20, SD = 2
x
summary(x)

set.seed(1)  # numbers generated afterwards will be same when calling seed again
rnorm(5)
rnorm(5)
set.seed(1)  # same numbers generate above
rnorm(5)
rnorm(5)

# generating Poisson data
rpois(10, 1)

rpois(10, 2)

rpois(10, 20)

ppois(2, 2) # cumulative distribution
            # probability Poisson random variable is less than 2 with rate of 2
[1] 0.6766764 # Pr(x <= 2)

ppois(4, 2)
[1] 0.947347  # Pr(x <= 4)

ppois(6, 2)
[1] 0.9954662 # Pr(x <= 6)

# linear model random number generation
# y = Bo + B1x + e
set.seed(2)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x, y)

set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x, y)

# Poisson model random number generator
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x, y)


# random sampling
set.seed(1)
sample(1:10, 4)
sample(1:10, 4)
sample(letters, 5)
sample(1:10) # permutation, or random order
sample(1:10) # permutation
sample(1:10, replace = TRUE)  # replacement, numbers can repeat


# R Profiling
# elapsed time > user time
system.time(readLines("http://www.jhsph.edu"))

# elapsed time < user time
hilbert <- function(n) {
        i <- 1:n
        1 / outer(i - 1, i, "+")
}
x <- hilbert(1000)
system.time(svd(x))

# wrapping everything in curly braces to time longer expression
system.time({
        n <- 100
        r <- numeric(n)
        for(i in 1:n) {
                x <- rnorm(n)
                r[i] <- mean(x)
        }
})

# simulating a dice 






