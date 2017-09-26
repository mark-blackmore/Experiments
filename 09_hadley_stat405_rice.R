#' ---
#' title: "Lecture 8 for Hadley Wickham's STAT 405 at Rice U. \t Functions $ for loops" 
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---
#' 
#' ## Slots Strategy
#' How can we determine if all of the windows are B, BB, or BBB?
windows <- c("7", "C", "C") 
windows[1] %in% c("B", "BB", "BBB")
windows %in% c("B", "BB", "BBB")

allbars <- windows %in% c("B", "BB", "BBB")
allbars[1] & allbars[2] & allbars[3]
all(allbars)

#' Complete the previous code so that the
#' correct value of prize is set if all the
#' windows are the same, or they are all bars
payoffs <- c("DD" = 800, "7" = 80, "BBB" = 40,
             "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
same <- length(unique(windows)) == 1
allbars <- all(windows %in% c("B", "BB", "BBB"))
if (same) {
  prize <- payoffs[windows[1]]
} else if (allbars) {
  prize <- 5
}

#' Need numbers of cherries, and numbers
#' of diamonds (hint: use sum)
#' Then need to look up values (like for the
#'first case) and multiply together
cherries <- sum(windows == "C")
diamonds <- sum(windows == "DD")
c(0, 2, 5)[cherries + 1]  *
  c(1, 2, 4)[diamonds + 1]

payoffs <- c("DD" = 800, "7" = 80, "BBB" = 40,
             "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
same <- length(unique(windows)) == 1
allbars <- all(windows %in% c("B", "BB", "BBB"))
if (same) {
  prize <- payoffs[windows[1]]
} else if (allbars) {
  prize <- 5
} else {
  cherries <- sum(windows == "C")
  diamonds <- sum(windows == "DD")
  prize <- c(0, 2, 5)[cherries + 1] *
    c(1, 2, 4)[diamonds + 1]
}
prize

#' ## Writing a Function
#' Now we need to wrap up this code into a
#' reusable tool. We need a function.
#' We've used functions a lot, and now it's
#' time to learn how to write one.  
#'  
#' ### What We Want
# calculate_prize(c("DD", "DD", "DD"))
# calculate_prize(c("B", "BBB", "BB"))
# calculate_prize(c("B", "7", "C"))

calculate_prize <- function(windows) {
  payoffs <- c("DD" = 800, "7" = 80, "BBB" = 40,
               "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
  same <- length(unique(windows)) == 1
  allbars <- all(windows %in% c("B", "BB", "BBB"))
  if (same) {
    prize <- payoffs[windows[1]]
  } else if (allbars) {
    prize <- 5
  } else {
    cherries <- sum(windows == "C")
    diamonds <- sum(windows == "DD")
    prize <- c(0, 2, 5)[cherries + 1] *
      c(1, 2, 4)[diamonds + 1]
  }
  prize
}

#' ### Functions: Default values
mean <- function(x) {
  sum(x) / length(x)
}
mean(1:10)

mean <- function(x, na.rm = FALSE) {
  if (na.rm) x <- x[!is.na(x)]
  sum(x) / length(x)
}
mean(c(NA, 1:9))
mean(c(NA, 1:9), na.rm = FALSE)
mean(c(NA, 1:9), na.rm = TRUE)

#' ### Exercise: Create Function to Compute Sample Variance
#' Start simple; use test values; check steps; wrap it up
#' Test Values
x <- runif(100)
var(x)

#' Steps
n <- length(x)
xbar <- mean(x)
x - xbar
(x - xbar) ^ 2
sum(x - xbar) ^ 2
sum((x - xbar) ^ 2)
sum((x - xbar) ^ 2) / n - 1
sum((x - xbar) ^ 2) / (n - 1) 

#' Wrap it Up
my_var <- function(x) {
  n <- length(x)
  xbar <- mean(x)
  sum((x - xbar) ^ 2) / (n - 1)
}

#' Clean Up
rm(list = ls())

#' ## For Loops  
library(ggplot2)
cuts <- levels(diamonds$cut)
for(cut in cuts) {
  selected <- diamonds$price[diamonds$cut == cut]
  print(cut)
  print(mean(selected))
}
#' Have to do something with output! 
#' 
#' ### Common pattern: create object for output, then fill with results
cuts <- levels(diamonds$cut)
means <- rep(NA, length(cuts))
for(i in seq_along(cuts)) {
  sub <- diamonds[diamonds$cut == cuts[i], ]
  means[i] <- mean(sub$price)
}
#' We will learn more sophisticated ways to do this
#' later on, but this is the most explicit

1:5 
seq_len(5)
1:10
seq_len(10)
1:0
seq_len(0)
seq_along(1:10)
1:10 * 2
seq_along(1:10 * 2)

#' ### Exercise
#' For each diamond colour, calculate the
#' median price and carat size
colours <- levels(diamonds$color)
n <- length(colours)
mprice <- rep(NA, n)
mcarat <- rep(NA, n)
for(i in seq_len(n)) {
  set <- diamonds[diamonds$color == colours[i], ]
  mprice[i] <- median(set$price)
  mcarat[i] <- median(set$carat)
}
results <- data.frame(colours, mprice, mcarat)
knitr::kable(results)



