#-----------------------------#
#John Hamm
#Coursera Week 1
#06/13/2017-06/16/2017
#-----------------------------#

#factors
x <- factor(c("Male", "Female"))
  levels = c("Male", "Female")
x

#dataframe
y <- data.frame(foo = 1:4, bar = c(T, T, F, F))
y
nrow(y)
ncol(y)

#names
z <- 1:3
names(z)
names(z) <- c("foo", "bar", "norf")
z
names(z)

#lists can have names
l <- list(a =1, b =  2, c = 3)
print(l)

#matrices can have names
m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d"))
m

#dput-ting R Objects
d <- data.frame(a = 1, b = "a")
dput(d)
dput(d, file = "d.R")
new.d <- dget("d.R")
new.d

#Dumping R Objects (multiple R objects)
f <- "dumping"
framing <- data.frame(a = 1, b = "a")
dump(c("f","framing"), file = "data.R")
rm(f, framing)
source("data.R")
f
framing

#Subsetting basic objects
Subobject <- c("a", "b", "c", "c", "d", "a")
Subobject[1]
Subobject[2]
Subobject[1:4]
Subobject[Subobject > "a"]
u <- Subobject >"a"
u
Subobject[u]

#Subsetting Lists
Li <- list(foo = 1:4, bar = 0.6, baz ="hello")
Li
Li$bar
Li[["bar"]]
Li["bar"] #list
Li[c(1, 3)]

#Subsetting Matrices
ma <- matrix(1:6, 2, 3)
ma[1, 2]
ma[2, 1]
ma[1, ]
ma[, 2]
ma[1, 2, drop = FALSE]

#Partial Matching
PM <- list(aardvark = 1:5)
PM$a
PM[["a"]]
PM[["a", exact = FALSE]]

#Removing NA Values
remo <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(remo)
remo[!bad]

remo2 <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(remo, remo2)
good
remo[good]
remo2[good]

#Vectorized Operations
v <- 1:4; w <- 6:9
v + w #add
v > 2 #check
v >= 2 #check
w == 8 #check
v * w #multiply
v / w #divide
#Vectorized Matrix Operation
n <- matrix(1:4, 2, 2); o <- matrix(rep(10, 4), 2, 2)#repeat is all same number
n * m ## element-wise multiplicaiton
n / m
n %*% m ##actual matrix multiplication
#---------------------------------------------------------------------------------------#