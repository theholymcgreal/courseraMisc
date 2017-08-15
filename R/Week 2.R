# if-else statement
if(x > 3) {
      y <- 10
} else {
        y <- 0
}

y <- if(x > 3) {
        10
} else {
        0
}


#for loop
x <- c("a", "b", "c", "d")

for(i in 1:4) {
    print(x[i])
}

for(i in seq_along(x)) {
      print(x[i])
}

for(letter in x) {
      print(letter)
}

for(i in 1:4) print(x[i])

# for loop nested
x <- matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))) {
      for(j in seq_len(ncol(x))) {
            print(x[i, j])
      }
}

# while loop
count <- 0
while(count < 10) {
      print(count)
  count <- count + 1
}

z <- 5

while(z >= 3 && z <= 10) {
        print(z)
        coin <- rbinom(1, 1, 0.5)
      
        if(coin == 1) {  # random walk
              z <- z + 1
        } else {
                z <- z - 1
        }
}

# repeat
x0 <- 1
tol <- 1e-8

repeat {
        x1 <- computeEstimate()
        
        if(abs(x1 - x0) < tol) {
                break
        } else {
                x0 <- x1
        }
}

# next, return
for(i in 1:100) {
        if(i <= 20) {
                # skip the first 2- iterations
                next
        }
        # do something here
}

# functions
f <- function(<arguments>) {
        # do something interesting
}

# function with 4 arguments
f <- function(a, b = 1, c = 2, d = NULL) {
        
}

# "..." argument
myplot <- function(x, y, type = "l", ...) {
        plot(x, y, type = type, ...)
}

args(paste)
function (..., sep = " ", collapse = NULL)
args(cat)
function (..., file = "", sep = " ", fill = FALSE,
        labels = NULL, append = FALSE)

paste("a", "b", sep = ":")



# lexical scoping
make.power <- function(n) {
        pow <- function(x) {
                x^n
        }
        pow
}
# function returns another function as its value
cube <- make.power(3)
square <- make.power(2)
cube(3)
square(3)

# look at the env in which the function was defined
# by calling ls function
ls(environment(cube))
get("n", environment(cube))

ls(environment(square))
get("n", environment(square))

y <- 10

f <- function(x) {
        y <- 2      # y is stored locally
        y^2 + g(x)  # y and g are free variables
}
g <- function(x) {
        x*y         # y is called from defined y = 10
}
f(3)

# constructor function
make.NegLogLik <- function(data, fixed=c(FALSE, FALSE)) {
        params <- fixed
        function(p) {
                params[!fixed] <- p
                mu <- params[1]
                sigma <- params[2]
                a <- -0.5*length(data)*log(2*pi*sigma^2)
                b <- -0.5*sum((data-mu)^2) / (sigma^2)
                -(a + b)
        }
}

set.seed(1); normals <- rnorm(100, 1, 2)
nLL <- make.NegLogLik(normals)
nLL
ls(environment(nLL)) # free variables defined in the defining environment

# estimating parameters
optim(c(mu = 0, sigma = 1), nLL)$par

# fixing sigma = 2
nLL <- make.NegLogLik(normals, c(FALSE, 2))
optimize(nLL, c(-1, 3))$minimum

# fixing mu = 1
nLL <- make.NegLogLik(normals, c(1, FALSE))
optimize(nLL, c(1e-6, 10))$minimum

# plotting the likelihood
nLL <- make.NegLogLik(normals, c(1, FALSE))
x <- seq(1.7, 1.9, len = 100)
y <- sapply(x, nLL)
plot(x, exp(-(y- min(y))), type = "l")

nLL <- make.NegLogLik(normals, c(FALSE, 2))
x <- seq(0.5, 1.5, len = 100)
y <- sapply(x, nLL)
plot(x, exp(-(y - min(y))), type = "l")

# coding standards
# always use text files
# indent
# limit to 80 columns
# limit length of individual functions

# dates and times
# dates
x <- as.Date("1970-01-01")
x
unclass(x)      # 0 days since 1970-01-01
unclass(as.Date("1970-01-02"))  # 1 day since 1970-01-02

# times can be coerced from a character string using the as.POSIXlt or as.POSIXct
x <- Sys.time()
x

p <- as.POSIXlt(x)
names(unclass(p)) #names of elements of this list

p$sec   #number of seconds in the time

# using POSIXct
x <- Sys.time()
x # already in POSIXct format

unclass(x)

x$sec   # error $ is invalid for atomic vectors

p <- as.POSIXlt(x)
p$sec


# strptime
datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x

class(x)

# operations on dates and times
x <- as.Date("2012-01-01")
y <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S")
x-y #incompatible methods ("-.Date", "-.POSIXlt") for "-"
        # error: non-numeric arg to binary operator
x <- as.POSIXlt(x)
x-y

# keeps tack of leap years, leap seconds, daylight savings, and time zones
x <- as.Date("2012-03-01") 
y <- as.Date("2012-02-28")
x-y
x <- as.POSIXct("2012-10-25 01:00:00")
y <- as.POSIXct("2012-10-25 06:00:00", tz = "GMT")
y-x





