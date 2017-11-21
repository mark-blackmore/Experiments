#' ---
#' title: "Lecture 4: Subsetting"
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---

library(ggplot2)

#' ## Subsetting
diamonds[diamonds$x > 10, ]
diamonds[1:10, c("carat", "cut")]

#' ### Blank
str(diamonds[, ])

#' ### Positive integers & nothing
diamonds[1:6, ] # same as head(diamonds)
# diamonds[, 1:4] # watch out!

#' ### Two positive integers in rows & columns
diamonds[1:10, 1:4]

#' ### Repeating input repeats output
diamonds[c(1,1,1,2,2), 1:4]

#' ### Negative integers
diamonds[-(1:53900), -1]

#' ### Logical
x_big <- diamonds$x > 10
head(x_big)
sum(x_big)
mean(x_big)
table(x_big)
diamonds$x[x_big]
diamonds[x_big, ]

#' ### Logical vectors
small <- diamonds[diamonds$carat < 1, ]
lowqual <- diamonds[diamonds$clarity
                    %in% c("I1", "SI2", "SI1"), ]

#' ### Boolean operators: & | !
small <- diamonds$carat < 1 & diamonds$price > 500
lowqual  <- diamonds$color == "D" | diamonds$cut == "Fair"
notcolor <- diamonds[!diamonds$color %in% c("D", "E", "F"), ]

#' ### Character subsetting
diamonds[1:5, c("carat", "cut", "color")]
diamonds[1:5, c(4, 9, 3)]

#' ### Useful technique: change labelling
labels <- c("Fair" = "C", "Good" = "B", "Very Good" = "B+", "Premium" = "A",
            "Ideal" = "A+")
labels
labels["Fair"]
labels["Very Good"]
first_10 <- diamonds$cut[1:10]
first_10
labels[first_10]
all <- labels[diamonds$cut]
table(all)
table(diamonds$cut)


#' ### Can also be used to collapse levels
table(c("Fair" = "C", "Good" = "B", "Very Good" =
          "B", "Premium" = "A", "Ideal" = "A")[diamonds$cut])

#' #### If you're confused by a big statement, break it up in to smaller pieces
grades <- c("Fair" = "C", "Good" = "B", "Very Good"
            = "B", "Premium" = "A", "Ideal" = "A")
grades
cuts <- diamonds$cut
head(grades[cuts])
table(grades[cuts])
# ?cut # continuous equivalent

#' ### Exercise
head(mpg)
str(mpg)
mpg$fl <- as.character(mpg$fl) 

fueltype <- c("r" = "regular", "d" = "other", "p" = "premium", "c" = "other",
              "e" = "other")
table(fueltype[mpg$fl])

#' ## Missing Values & Outliers
qplot(x, y, data = diamonds)
qplot(x, z, data = diamonds)

y_big <- diamonds$y > 20
z_big <- diamonds$z > 20
x_zero <- diamonds$x == 0
y_zero <- diamonds$y == 0
z_zero <- diamonds$z == 0
zeros <- x_zero | y_zero | z_zero
bad <- y_big | z_big | zeros
good <- diamonds[!bad, ]

qplot(x, y, data = good)
qplot(x, y, data = good, alpha = I(1/100))

#' ### Guess what happens
5 + NA
NA / 2
sum(c(5, NA))
mean(c(5, NA))
NA < 3
NA == 3
NA == NA # uses is.na() to check for missing values

#' ### Can use subsetting + <- to change individual values
#+ warning = FALSE
diamonds$x[diamonds$x == 0] <- NA
diamonds$y[diamonds$y == 0] <- NA
diamonds$z[diamonds$z == 0] <- NA
y_big <- diamonds$y > 20
diamonds$y[y_big] <- NA
z_big <- diamonds$z > 20
diamonds$z[y_big] <- NA
qplot(x, y, data = diamonds)

## Clean up
rm(list = ls())
              