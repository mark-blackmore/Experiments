#' ---
#' title: "Lecture 3: Scatterplots for Big Data, Subsetting"
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---

library(ggplot2)
library(plyr)

#' ## Why are poorer cuts more expensive?
qplot(price, ..density.., data = diamonds, binwidth = 500,
      geom = "freqpoly", colour = cut)

#' ## What variable is most important for price?
qplot(carat, price, data= diamonds, color = cut)

#' ### Two ways to add a smoothed conditional mean
qplot(carat, price, data= diamonds, color = cut, geom = c("point", "smooth"))
qplot(carat, price, data= diamonds, color = cut) + 
  geom_smooth()

#' ### To set aesthetics to a particular value, you need to wrap that value in I()
qplot(price, carat, data = diamonds, colour = "blue")
qplot(price, carat, data = diamonds, colour = I("blue"))

#' ### Practical application: varying alpha
qplot(carat, price, data = diamonds, alpha = I(1/10))
qplot(carat, price, data = diamonds, alpha = I(1/50))
qplot(carat, price, data = diamonds, alpha = I(1/100))
qplot(carat, price, data = diamonds, alpha = I(1/250))

#' ### Need to specify grouping variable  
#' what determines which observations go into each boxplot
qplot(table, price, data = diamonds)
qplot(table, price, data = diamonds,
      geom = "boxplot")
qplot(table, price, data = diamonds,
      geom = "boxplot", group = round_any(table, 1))
qplot(table, price, data = diamonds,
      geom = "boxplot", group = round_any(table, 1)) + xlim(50, 70)

#' ## Subsetting  
#' 
#' ### Example Data
x <- sample(1:10)
y <- setNames(x, letters[1:10])

#' ### Subsetting: How
x[1:4]
x[x == 5]
y[order(y)]
x[]
x[-1]
y["a"]
x[x]
x[x > 2 & x < 9]
x[sample(10)]
x[order(x)]
x[-(1:5)]
x["a"]
y[letters[10:1]]
x[x < 2 | x >= 8]
# x[-1:5]
x[0]

#' #### Everything
str(diamonds[, ])

#' #### Positive integers & nothing
diamonds[1:6, ] # same as head(diamonds)
# diamonds[, 1:4] # watch out!

#' #### Two positive integers in rows & columns
diamonds[1:10, 1:4]

#' #### Repeating input repeats output
diamonds[c(1,1,1,2,2), 1:4]

#' #### Negative integers drop values
diamonds[-(1:53900), -1]

#' ### Using logicals
x_big <- diamonds$x > 10
head(x_big)
sum(x_big)
mean(x_big)
table(x_big)
diamonds$x[x_big]
diamonds[x_big, ]
small <- diamonds[diamonds$carat < 1, ]
lowqual <- diamonds[diamonds$clarity %in% c("I1", "SI2", "SI1"), ]
small <- diamonds$carat < 1 &
  diamonds$price > 500

#' ### Exercise
logical_answer <- diamonds$x == diamonds$y & diamonds$depth > 55 & 
  diamonds$depth < 70 & diamonds$carat < mean(diamonds$carat) & 
  diamonds$cut %in% c("Good", "Very Good", "Premium", "Ideal")
diamonds[logical_answer,]
