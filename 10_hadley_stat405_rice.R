#' ---
#' title: "Lecture 10 for Hadley Wickham's STAT 405 at Rice U. \t Simulation" 
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---
#'
#' ## For Loops
#' # Common pattern: create object for output, then fill with results
library(ggplot2)
cuts <- levels(diamonds$cut)
means <- rep(NA, length(cuts))
for(i in seq_along(cuts)) {
  sub <- diamonds[diamonds$cut == cuts[i], ]
  means[i] <- mean(sub$price)
}
#' We will learn more sophisticated ways to do this
#' later on, but this is the most explicit
#' 
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
