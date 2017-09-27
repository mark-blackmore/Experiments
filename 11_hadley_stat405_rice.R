#' ---
#' title: "Lecture 11 for Hadley Wickham's STAT 405 \t Advanced Data Manipulation" 
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---
#'
#' ## Baby names data
#' Top 1000 male and female baby
#' names in the US, from 1880 to 2008.
#' 258,000 records (1000 * 2 * 129)
#' But only five variables: year,
#' name, soundex, sex and prop.
#' 
file_bnames <- "http://stat405.had.co.nz/data/bnames2.csv.bz2"
file_births <- "http://stat405.had.co.nz/data/births.csv" 

library(plyr)
library(ggplot2)
options(stringsAsFactors = FALSE)
download.file(file_bnames, destfile = "./data/bnames2.csv.bz2")
download.file(file_births, destfile = "./data/births.csv")
bnames <- read.csv("./data/bnames2.csv.bz2")
births <- read.csv("./data/births.csv")

head(bnames, 20)
tail(bnames, 20)

#' ### Exercise: 
#' Extract your name from the dataset. Plot
#' the trend over time.
#' What geom should you use? Do you
#' need any extra aesthetics?

mark <- subset(bnames, name == "Mark")
qplot(year, prop, data = mark, color = sex, geom = "line")

sheryl <- subset(bnames, name == "Sheryl")
qplot(year, prop, data = sheryl, geom = "line")

garret <- subset(bnames, name == "Garret")
hadley <- subset(bnames, name == "Hadley")
qplot(year, prop, data = garret, geom = "line")
qplot(year, prop, data = hadley, color = sex,
      geom = "line")
