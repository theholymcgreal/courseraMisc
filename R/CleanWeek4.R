# editing text variables
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
# make all letters lowercase
tolower(names(cameraData))
# separate out variables wiith values separated by periods
splitNames = strsplit(names(cameraData), "\\.")
splitNames[[6]]
# quick aside - lists
myList <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(myList)
myList[1]
myList$letters
myList[[1]]
# fixing character vectors - sapply
splitNames[[6]][1]
firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)
# fixing character vectors - sub()
names(reviews)
sub("_", "", names(reviews),)
# fixing character vectors - gsub()
testName <- "this_is_a_test"
sub("_","",testName)   # replaces first underscore
gsub("_","",testName)  # replaces all underscores
# finding values - grep(), grepl()
grep("Alameda", cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),]
# more on grep()
grep("Alameda", cameraData$intersection, value=T)
grep("JeffStreet", cameraData$intersection)
length(grep("JeffStreet", cameraData$intersection)) # if 0, value doesnt appear
# more useful functions
library(stringr)
nchar("Colin")
substr("Colin", 1, 3)
paste("colin", "Hodor")
paste0("colin", "hodor")
str_trim("colin      ")



# regular expressions
# literal is a literal word
# metacharacters
# ^ represents start of line
# $ represents end of line
# character classes
# [Bb] [Uu] [Ss] [Hh] all versions of bUsH
# ^[Ii] am : start of the line, either I and literal am
# ^[0-9][a-zA-Z] beginning of line, look for a number followed by a letter
# [^?.]$ anything that ends in . or ?
# 9.11 : . could be any character
# flood|fire : or operator
# flood|earthquake|hurricane|fire
# ^[Gg]ood|[Bb]ad  : beginning or alternative
# (^[Gg]ood|[Bb]ad) restricts alternative
# [Gg]eorge( [Ww]\.)? [Bb]ush : ? indicates indicated expression is optional
        # \. means literal dot, its an escape character
# (.*) : * and + indicate repition
# [0-9]+ (.*)[0-9]+ : at least 1 number followed by any number of char followed by number again
# [Bb]ush( +[^ ]+ +){1, 5} debate : { are interval qualifiers : one and five word like objects between bush and debate
# m,n : means at least m but not more than n matches
# m   :means exactly m matches
# m,  :means at least m matches
# +( [a-zA-Z]+) +\1 +  : repition of a phrase
# ^s(.*)s  : s followed by char followed by s
# ^s(.*?)s$  : start with s, small number of char followed by s, less greedy




# working with dates
d2 = Sys.Date()
d2
# formatting dates
format(d2, "%a %b %d")
# creating dates
x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960"); z = as.Date(x, "%d%b%y")
z
z[1] - z[2]
as.numeric(z[1]-z[2])
#converting to Julian
weekdays(d2)
months(d2)
julian(d2) # days since origin date
# lubridate
library(lubridate)
ymd("20140108")
mdy("08/04/2013")
dmy("03-04-2013")
# dealing with times
ymd_hms("2011-08-03 1-:15:03")
ymd_hms("2011-08-03 10:15:03", tz="Pacific/Auckland")
# some functions have different syntax
x = dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
wday(x[1])







# free data 
