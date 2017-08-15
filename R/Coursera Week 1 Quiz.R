#Q11 In the dataset provided for this Quiz, what are the column names of the dataset?
DT <- read.csv("hw1_data.csv")
Q11 <- colnames(DT)
Q11

#Q12 Extract the first 2 rows of the data frame and print them to the console. What does the output look like?
HEAD <- read.csv("hw1_data.csv", header = TRUE, nrows = 2)
HEAD

#Q13 How many observations (i.e. rows) are in this data frame?
nrow(DT)

#Q14 Extract the last 2 rows of the data frame and print them to the console. What does the output look like?
DT[152:153, ]

#Q15 What is the value of Ozone in the 47th row?
DT$Ozone[47]

#Q16 How many missing values are in the Ozone column of this data frame?
sum(is.na(DT$Ozone))

#Q17 What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.
mean(DT$Ozone, na.rm = TRUE)

#Q18 Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?
mean(DT[DT$Ozone > 31 & DT$Temp > 90,] $Solar.R, na.rm = T)

#Q19 What is the mean of "Temp" when "Month" is equal to 6?
mean(DT[DT$Month == 6,]$Temp, na.rm = T)

#Q20 What was the maximum ozone value in the month of May (i.e. Month is equal to 5)?
max(DT[DT$Month == 5,] $Ozone, na.rm = T)

