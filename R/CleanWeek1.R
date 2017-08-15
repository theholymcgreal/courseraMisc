# checking for and creating directories
file.exists("directoryName") # check to see if exist
dir.create("directoryName") # creates a driectory

if(!file.exists("data")) {
        dir.create("data")
}

# getting data from the internet
download.file()

fileUrl <- "https://data.baltimorecity.gov/api/views/aqgr-xx9h/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
list.files("./data")
dateDownloaded <- date()
dateDownloaded

# reading local files
read.table() or read.csv()

cameraData <- read.table("./data/cameras.csv", sep = ",", header = T)
head(cameraData)

cameraData <- read.csv("./data/cameras.csv")
head(cameraData)

# reading excel files
if(!file.exists("data")) {dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/aqgr-xx9h/rows.csv?accessType=DOWNLOAD&bom=true&format=true"
download.file(fileUrl, destfile = "./data/cameras.xlsx", method = "curl")
dateDownloaded <- date()
library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, header= T)
head(cameraData)
        # reading specific rows and columns
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, 
                                colIndex =  colIndex, rowIndex = rowIndex)
cameraDataSubset

# reading XML
library(XML)
library(RCurl)
xmlUrl <- "https://www.w3schools.com/xml/simple.xml"
download.file(xmlUrl, "./data/w3schools.xml", method = "curl")
doc <- htmlTreeParse("./data/w3schools.xml", useInternalNodes = T)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

# direct access parts of XML doc
rootNode[[1]]
rootNode[[1]][[1]]

        # learn XPath
# get items on menu and prices
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)

# extract content by attributes
fileUrl <- "http://www.espn.com/nfl/team/_/name/cle/cleveland-browns"
doc <- htmlTreeParse(fileUrl, useInternalNodes = T)
dates <- xpathSApply(doc, "//div[@class='game-date']",xmlValue)
times <- xpathSApply(doc, "//div[@class='time']",xmlValue)
opponents <- xpathSApply(doc, "//div[@class='game-info']",xmlValue)
network <- xpathSApply(doc, "//div[@class='network ']",xmlValue)
dates
opponents
times
network

# reading JSON
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owners$login

# writin data frames to JSON
myjson <- toJSON(iris, pretty = T)
cat(myjson)
        # convert back to JSON
iris2 <- fromJSON(myjson)
head(iris2)


# using data.table
library(data.table)
DF = data.frame(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DF, 3)

DT = data.table(x=rnorm(9), y=rep(c("a","b","c"), each=3), z=rnorm(9))
head(DT, 3)

# see all data tables in memory
tables()
# subset rows
DT[2,]
DT[DT$y=="a",]
DT[c(2,3)]

# subset columns
        # expressions are between curly brackets
{
        x = 1
        y = 2
}
k = {print(10); 5}
print(k)

# calculate values for variables with expressions
DT[, list(mean(x), sum(z))] # passing a list performs functions and returns values
DT[, table(y)]
DT[, w:=z^2] # := adds variable to data table

DT2 <- DT
DT[, y:= 2]

head(DT, n=3)
head(DT2 , n=3)  # copy wasn't made so table two was changed was well

# multiple operations
DT[,m:= {tmp <- (x+z); log2(tmp+5)}]  
DT

# plyr like operations
DT[, a:=x>0]
DT

# special vairables
set.seed(123);
DT <- data.table(x=sample(letters[1:3], 1E5, T))
DT[, .N, by=x]  # .N number of times a particular group appears

# keys
DT <- data.table(x=rep(c("a", "b", "c"), each=100), y=rnorm(300))
setkey(DT, x) # subset and sort more rapidly with keys
DT['a']

# joins
DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 <- data.table(x=c('a', 'b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)

# fast reading
big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=F, col.names=T, sep="\t", quote = F)
system.time(fread(file))

system.time(read.table(file, header = T, sep="\t"))
        





