#' ---
#' title: "Lecture 7 for Hadley Wickham's STAT 405 at Rice U. \t More About Data" 
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---

library(ggplot2)
library(plyr)

#' ## Tips
#' If you know what the missing code is, use it
# read.csv(file, na.string = ".")
# read.csv(file, na.string = "-99")
#' Use count.fields to check the number of columns in each row. The following
#' call uses the same default as read.csv
# count.fields(file, sep = ",",
#             quote = "", comment.char = "")

#' ## Exercise: downloading tricky files
#' File URL's
fileUrl_1 <- "http://stat405.had.co.nz/data/tricky-1.csv"
fileUrl_2 <- "http://stat405.had.co.nz/data/tricky-2.csv"
fileUrl_3 <- "http://stat405.had.co.nz/data/tricky-3.csv"
fileUrl_4 <- "http://stat405.had.co.nz/data/tricky-4.csv"

#' Download files 
download.file(fileUrl_1, destfile = "./data/tricky-1.csv")
download.file(fileUrl_2, destfile = "./data/tricky-2.csv")
download.file(fileUrl_3, destfile = "./data/tricky-3.csv")
download.file(fileUrl_4, destfile = "./data/tricky-4.csv")
list.files("./data")

#' Load files into workspace
tricky_1 <- read.csv("./data/tricky-1.csv")
tricky_1
tricky_2 <- read.csv("./data/tricky-2.csv", header = FALSE)
tricky_2
tricky_3 <- read.delim("./data/tricky-3.csv", sep = "|")
tricky_3
tricky_4 <- count.fields("./data/tricky-4.csv", sep = ",")
tricky_4

#' ## Exercise: clean slots.txt to look like slots.csv
#' Start by examining the files using RStudio text editor  
#' <br>

#' File URL's
fileUrl_5 <- "http://stat405.had.co.nz/data/slots.txt"
fileUrl_6 <- "http://stat405.had.co.nz/data/slots.csv"

#' ## Data Cleaning
#' Goal: convert slots.txt to clean version - slots.csv 
#' Download files
download.file(fileUrl_5, destfile = "./data/slots.txt")
download.file(fileUrl_6, destfile = "./data/slots.csv")

#' Load files into workspace
count.fields("./data/slots.txt", sep = "",
             quote = "", comment.char = "")
slots <- read.delim("./data/slots.txt", sep = " ")
slots_clean <- read.csv("./data/slots.csv")
head(slots_clean)

#' ### Variable Names
#' This is a very common pattern  
names(slots)
names(slots) <- c("w1", "w2", "w3",
                  "prize", "night")
dput(names(slots))

#' ## Strings and Factors
#' By default, strings converted to factors when
#' loading data frames. I think this is the wrong
#' default - you should always explicitly convert
#' strings to factors. Use stringsAsFactors = F to 
#' avoid this.
#' For one data frame:
# read.csv("mpg.csv.bz2", stringsAsFactors = F)
#' For entire session:
# options(stringsAsFactors = F)

#' ### Creating a factor
x <- sample(5, 20, rep = T)
a <- factor(x)
b <- factor(x, levels = 1:10)
c <- factor(x, labels = letters[1:5])
levels(a); levels(b); levels(c)
table(a); table(b); table(c)

#' ### Create factors on slots data
slots <- read.delim("./data/slots.txt", sep = " ", header = F,
                    stringsAsFactors = F)
names(slots) <- c("w1", "w2", "w3", "prize", "night")
levels <- c(0, 1, 2, 3, 5, 6, 7)
labels <- c("0", "B", "BB", "BBB", "DD", "C", "7")
slots$w1 <- factor(slots$w1, levels = levels, labels = labels)
slots$w2 <- factor(slots$w2, levels = levels, labels = labels)
slots$w3 <- factor(slots$w3, levels = levels, labels = labels)

