#' ---
#' title: "Lecture 2 for Hadley Wickham's STAT 405 at Rice U. \t Distributions"
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---

library(ggplot2)

#' ## Five ways to explore the data
# ?diamonds
head(diamonds)
str(diamonds)
summary(diamonds)
qplot(reorder(cut, price, median), log(price), data = diamonds, geom = "boxplot")

#' ## Examine distributions 

#' ### Categorical variable generates barplot 
qplot(cut, data = diamonds)

#' ### Continuous variable generates histogram
qplot(carat, data = diamonds)
qplot(carat, data = diamonds, binwidth = 1)
qplot(carat, data = diamonds, binwidth = 0.1)
qplot(carat, data = diamonds, binwidth = 0.01)
resolution(diamonds$carat)
last_plot() + xlim(0, 3)

#' ### Always play with binwidth
qplot(table, data = diamonds, binwidth = 1)
qplot(table, data = diamonds, binwidth = 1) +
  xlim(50, 70)
qplot(table, data = diamonds, binwidth = 0.1) +
  xlim(50, 70)
qplot(table, data = diamonds, binwidth = 0.1) +
  xlim(50, 70) + ylim(0, 50)

#' ### Different ways to zoon
# ?coord_cartesian
d <- ggplot(diamonds, aes(carat, price)) +
  stat_bin2d(bins = 25, colour = "white")
d
d + scale_x_continuous(limits = c(0, 1))
d + coord_cartesian(xlim = c(0, 1))

#' ### Using Aesthetics
qplot(depth, data = diamonds, binwidth = 0.2)
qplot(depth, data = diamonds, binwidth = 0.2,
      fill = cut) + xlim(55, 70)
qplot(depth, data = diamonds, binwidth = 0.2) + 
  xlim(55, 70) + facet_wrap(~ cut)

#' ### Exercise: Expriment with binwidth and aesthetics
qplot(price, data = diamonds)
resolution(diamonds$price)
qplot(price, data = diamonds, binwidth = 1)
qplot(price, data = diamonds, binwidth = 10)
qplot(price, data = diamonds, binwidth = 100)
qplot(price, data = diamonds, binwidth = 1000)
qplot(price, data = diamonds, binwidth = 100) + 
  coord_cartesian(xlim = c(0, 5000))
qplot(price, data = diamonds, binwidth = 500) + 
  scale_x_continuous(limits = c(0, 5000))
qplot(price, data = diamonds, binwidth = 500) + facet_wrap(~ color)
qplot(price, data = diamonds, binwidth = 100) + facet_wrap(~ cut)
qplot(price, data = diamonds, binwidth = 100) + facet_wrap(~ clarity)

#' ### Preferable to use density for comparions vs count
qplot(price, data = diamonds, binwidth = 500) + facet_wrap(~ cut)
qplot(price, ..density.., data = diamonds, binwidth = 500,
      geom = "freqpoly", colour = cut)
qplot(price, ..density.., data = diamonds, binwidth = 500,
      geom = "histogram") + facet_wrap(~ cut)
