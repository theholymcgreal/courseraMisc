add2 <- function(x, y) {
        x + y
}

# take avector of numbers and return subset of numbers greater than 10
above10 <- function(x) {
        use <- x > 10
        x[use]
}

above <- function(x, n = 10) {
        use <- x > n
        x[use]
}

# calculate mean of a column in a matrix
columnMean <- function(y, removeNA = TRUE) {
        nc <- ncol(y)
        means <- numeric(nc)
        for(i in 1:nc) {
                means[i] <- mean(y[, i], na.rm = removeNA)
        }
        means
}