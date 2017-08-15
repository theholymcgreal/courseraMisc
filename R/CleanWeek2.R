# MySQL
# connecting and listing databases
ucscDb <- dbConnect(MySQL(), user="genome",
                    host="genome-mysql.soe.ucsc.edu") # opens connection
result <- dbGetQuery(ucscDb,"show databases;"); dbDisconnect(ucscDb); # apply a query MySQL command "show databases"
                                                                        # always disconnect                
result
# connecting to hg19 and listing tables
hg19 <- dbConnect(MySQL(), user="genome", db="hg19", # db within server
                  host="genome-mysql.soe.ucsc.edu")
allTables <- dbListTables(hg19)  # tables within db
length(allTables)
allTables[1:5]
# get dimensions of a specific table
dbListFields(hg19, "affyU133Plus2")  # column names
dbGetQuery(hg19, "select count(*) from affyU133Plus2") # how many rows
# read from table
affyData <- dbReadTable(hg19, "affyU133Plus2") # get data out
head(affyData)
# select a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)  # returns affyMis

affyMisSmall <- fetch(query,n=10); dbClearResult(query); # clear query from remote server
dim(affyMisSmall)
# DONT FORGET TO CLOSE CONNECTION
dbDisconnect(hg19)


# reading from HDF5
library(rhdf5)
created = h5createFile("example.h5")
created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa") # subgroup
h5ls("example.h5") # listing out hdf5 file
# write to groups
A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A") # write matrix to group
B = array(seq(0.1, 2.0, by=0.1), dim=c(5,2,2)) 
attr(B, "scale") <- "liter" # give it metadata
h5write(B, "example.h5","foo/foobaa/B") # write array to subgrop
h5ls("example.h5")
# write a data set
df = data.frame(1L:5L, seq(0,1, length.out=5),
                c("ab","cde","fghi","a","s"), stringsAsFactors = FALSE)
h5write(df, "example.h5","df") # write directly to top level group
h5ls("example.h5")
# reading data
readA =h5read("example.h5","foo/A")
readA
# writing and reading chunks
h5write(c(12,13,14), "example.h5","foo/A",index=list(1:3,1)) # write to data set
h5read("example.h5","foo/A") 


# reading data from the web
con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ")
htmlCode = readLines(con)
close(con)
htmlCode
# parsing with XML
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ"
html <- htmlTreeParse(url, useInternalNodes = TRUE)
xpathSApply(html, "//title", xmlValue)
# GET from httr package
library(httr); html2 = GET(url)
content2 = content(html2, as="text") # extract content as text string
parsedHtml = htmlParse(content2, asText = TRUE) # parse out text 
xpathSApply(parsedHtml, "//title", xmlValue) # exactly like XML package output
# accessing websites with passwords
pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd"))
pg2  
names(pg2) 
# using handles
google = handle("http://google.com") # keep authetication throughout handle
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")


# Reading data from APIs
# create application
# accesing twitter from R
myapp = oauth_app("semrush",
                  key="426039396449bdbc7770eb68dad320ec", secret = NULL)
sig = sign_oauth1.0(myapp,
                    token = "joe.kanyok@precisiondialogue.com",
                    token_secret = "grateful")
homeTL = GET("http://api.semrush.com/?key=426039396449bdbc7770eb68dad320ec&type=domain_ranks&export_columns=Db,Dn,Rk,Or,Ot,Oc,Ad,At,Ac,Sv,Sh&domain=seobook.com&database=us", sig)



        
# converting the json object
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]
# look at documentation for getting info












