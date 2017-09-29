#' ---
#' title: "Lecture 6 for Hadley Wickham's STAT 405 at Rice U. \t Statistical Reports" 
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---

library(ggplot2)
library(plyr)
library(knitr)

#' ## Example: Good code presentation  

#' Table and depth -------------------------
qplot(table, depth, data = diamonds)
qplot(table, depth, data = diamonds) +
  xlim(50, 70) + ylim(50, 70)

#' Is there a linear relationship?
qplot(table - depth, data = diamonds,
      geom = "histogram")

#' This bin width seems the most revealing
qplot(table / depth, data = diamonds,
      geom = "histogram", binwidth = 0.01) +
  xlim(0.8, 1.2)

# Also tried: 0.05, 0.005, 0.002

#' ## Exercise: rewrite the following with proper style
x <- c( 1,-2,3,-4,5,NA )
y <- x * - 1
y[ y>0 ]

#' ### Answer
x <- c(1, -2, 3, -4, 5, NA)
y <- x * -1
y[y > 0]
