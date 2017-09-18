# Lecture 1 for Hadley Wickhams' STAT 405 at Rice University
library(ggplot2)

## Five ways to explore the data
?mpg
head(mpg)
str(mpg)
summary(mpg)
qplot(displ, hwy, data = mpg)

## Quick plots
qplot(displ, hwy, colour = class, data = mpg)
qplot(displ, hwy, data = mpg) +
  facet_grid(. ~ cyl)
qplot(displ, hwy, data = mpg) +
  facet_grid(drv ~ .)
qplot(displ, hwy, data = mpg) +
  facet_grid(drv ~ cyl)
qplot(displ, hwy, data = mpg) +
  facet_wrap(~ class)
qplot(cty, hwy, data = mpg, geom = "jitter")
qplot(class, hwy, data = mpg)

## Quick Plots - change plot order with reorder()
qplot(reorder(class, hwy), hwy, data = mpg)
qplot(reorder(class, hwy), hwy, data = mpg, geom = "boxplot")
qplot(reorder(class, hwy, median), hwy, data = mpg, geom = "boxplot")
qplot(reorder(class, hwy, median), hwy, data = mpg, geom = c("boxplot", "jitter"))