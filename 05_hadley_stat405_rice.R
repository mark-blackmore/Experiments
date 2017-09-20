#' ---
#' title: "Lecture 5 for Hadley Wickham's STAT 405 at Rice U. \t Working 
#' directories, shortcuts and iteration"
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---

library(ggplot2)
library(plyr)

#' ## Working Directories
#' Never use setwd() in a scirpt
#' Find out what directory you're in with getwd()
#' List files in that directory with dir()

#' ### Exercise
#' Check for data directory; Create one if not found
if (!file.exists("data")) {
  dir.create("data")
  }

#' Source URL
fileUrl <- "http://stat405.had.co.nz/project/mpg2.csv.bz2"
download.file(fileUrl, destfile = "./data/mpg2.csv.bz2")
list.files("./data")

#' Load file into workspace
mpg2 <- read.csv("./data/mpg2.csv.bz2", stringsAsFactors = FALSE)

#' ### Exercise
#' Plot carat vs price
qplot(carat, price, data = diamonds)
#' Uses size on screen:
ggsave("my-plot.pdf")
ggsave("my-plot.png")
#' Specify size
ggsave("my-plot.pdf", width = 6, height = 6)
#' Plots are saved in the working directory
list.files(pattern = "^['my']")

#' ## Short Cuts
df <- data.frame(color = c("blue", "black", "blue", "blue", "black"),
                 value = c(1, 2, 3, 4, 5))
subset(df, color == "blue")

#' ### subset: short cut for subsetting
zero_dim <- diamonds$x == 0 | diamonds$y == 0 | diamonds$z == 0
diamonds[zero_dim, ]
subset(diamonds, x == 0 | y == 0 | z == 0)

summarise(df, double = 2 * value)
summarise(df, total = sum(value))

#' ### summarise/summarize: short cut for creating a summary
biggest <- data.frame(
  price.max = max(diamonds$price),
  carat.max = max(diamonds$carat))
biggest <- summarise(diamonds,
                     price.max = max(price),
                     carat.max = max(carat))

mutate(df, double = 2 * value)
mutate(df, double = 2 * value, 
       quad = 2 * double)

#' ### mutate: short cut for adding new variables
diamonds$volume <- diamonds$x * diamonds$y * diamonds$z
diamonds$density <- diamonds$volume / diamonds$carat
diamonds <- mutate(diamonds,
                   volume = x * y * z,
                   density = volume / carat)
head(diamonds)

df <- data.frame(color = c(4, 1, 5, 3, 2),
                 value = c(1, 2, 3, 4, 5))
arrange(df, color)
arrange(df, desc(color))

#' ### arrange: short cut for reordering
diamonds <- diamonds[order(diamonds$price,
                           desc(diamonds$carat)), ]
diamonds <- arrange(diamonds, price, desc(carat))
head(diamonds)

#' ### Exercise
large_stones <- subset(diamonds, carat > 3)
arrange(large_stones, desc(price))
diamonds <- mutate(diamonds,
                   diameter = (x + y) / 2,
                   depth2 = z / diameter * 100)
qplot(depth, depth2, data = diamonds)
qplot(depth - depth2, data = diamonds)

#' ### Use with()
with(diamonds, table(color, clarity))
#' with is more general. Use in concert with other functions, 
#' particularly those that don't have a data argument
diamonds$volume <- with(diamonds, x * y * z)
#' This won't work:
with(diamonds, volume <- x * y * z)
#' with only changes lookup, not assignment

# Clean up
rm(diamonds)

#' ## Iteration
#' Best data analyses tell a story, with a natural flow from beginning to end.
qplot(x, y, data = diamonds)
qplot(x, z, data = diamonds)

#' ### Start by fixing incorrect values
y_big <- diamonds$y > 10
z_big <- diamonds$z > 6
x_zero <- diamonds$x == 0
y_zero <- diamonds$y == 0
z_zero <- diamonds$z == 0
diamonds$x[x_zero] <- NA
diamonds$y[y_zero | y_big] <- NA
diamonds$z[z_zero | z_big] <- NA
qplot(x, y, data = diamonds)

#' ### How can I get rid of those outliers?
qplot(x, x - y, data = diamonds)
qplot(x - y, data = diamonds)
qplot(x - y, data = diamonds, binwidth = 0.01)
last_plot() + xlim(-0.5, 0.5)
last_plot() + xlim(-0.2, 0.2)
asym <- abs(diamonds$x - diamonds$y) > 0.2
diamonds_sym <- diamonds[!asym, ]

#' ### Did it work?
qplot(x, y, data = diamonds_sym)
qplot(x, x - y, data = diamonds_sym)

#' ### Something interesting is going on there!
qplot(x, x - y, data = diamonds_sym,
      geom = "bin2d", binwidth = c(0.1, 0.01))

#' ### What about x and z?
qplot(x, z, data = diamonds_sym)
qplot(x, x - z, data = diamonds_sym)

#' ### Subtracting doesn't work - z smaller than x and y
qplot(x, x / z, data = diamonds_sym)

#' ### But better to log transform to make symmetrical
qplot(x, log10(x / z), data = diamonds_sym)

#' ### How does symmetry relate to price?
qplot(abs(x - y), price, data = diamonds_sym) +
  geom_smooth()
diamonds_sym <- mutate(diamonds_sym,
                       sym = zapsmall(abs(x - y)))

#' ### Are asymmetric diamonds worth more?
qplot(sym, price, data = diamonds_sym) + geom_smooth()
qplot(sym, price, data = diamonds_sym, geom = "boxplot",
      group = sym)
qplot(sym, carat, data = diamonds_sym, geom = "boxplot",
      group = sym)
qplot(carat, price, data = diamonds_sym, colour = sym)
qplot(log10(carat), log10(price), data = diamonds_sym,
      colour = sym, group = sym) + geom_smooth(method = lm, se = F)

#' ## Modelling
summary(lm(log10(price) ~ log10(carat) + sym,
           data = diamonds_sym))

#' ### But statistical significance != practical significance
sd(diamonds_sym$sym, na.rm = T)
#' [1] 0.02368828
#' So 1 sd increase in sym, decreases log10(price)
#' by -0.01 (= 0.023 * -0.44)
#' 10 ^ -0.01 = 0.976; 0.976 - 1 = -0.024
#' So 1 sd increase in sym decreases price by ~2%
