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
names(slots)
names(slots) <- c("w1", "w2", "w3",
                  "prize", "night")
dput(names(slots))
#' This is a very common pattern

#' ## Strings & Factors