# Lecture 2 for Hadley Wickhams' STAT 405 at Rice University
library(ggplot2)

## Five ways to explore the data
?diamonds
head(diamonds)
str(diamonds)
summary(diamonds)
qplot(reorder(cut, price, median), log(price), data = diamonds, geom = "boxplot")

## Examine distributions 
### Categorical variable generates barplot 
qplot(cut, data = diamonds)

### Continuous variable generates histogram
qplot(carat, data = diamonds)
qplot(carat, data = diamonds, binwidth = 1)
qplot(carat, data = diamonds, binwidth = 0.1)
qplot(carat, data = diamonds, binwidth = 0.01)
resolution(diamonds$carat)
last_plot() + xlim(0, 3)

### Always play with binwidth
qplot(table, data = diamonds, binwidth = 1)
qplot(table, data = diamonds, binwidth = 1) +
  xlim(50, 70)
qplot(table, data = diamonds, binwidth = 0.1) +
  xlim(50, 70)
qplot(table, data = diamonds, binwidth = 0.1) +
  xlim(50, 70) + ylim(0, 50)
?coord_cartesian
d <- ggplot(diamonds, aes(carat, price)) +
  stat_bin2d(bins = 25, colour = "white")
d
d + scale_x_continuous(limits = c(0, 1))
d + coord_cartesian(xlim = c(0, 1))

