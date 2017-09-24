#' ---
#' title: "Lecture 8 for Hadley Wickham's STAT 405 at Rice U. \t Problem Solving" 
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---
#' 
#' ## Problem Solving
library(ggplot2)
mpg2 <- read.csv("./data/mpg2.csv.bz2", stringsAsFactors = FALSE)

#' ### Be sceptical
recent <- subset(mpg2, year >= 1998 &
                   fueltype %in% c("CNG", "Diesel", "Regular", "Premium"))
qplot(year, cty, data = recent, colour = fueltype,
      geom = "smooth")
qplot(year, cty, data = recent, colour = fueltype,
      geom = "jitter")

#' ### Be curious
qplot(year, cty, data = recent, geom = "boxplot", group = year) +
  facet_wrap(~ fueltype) +
  geom_smooth(colour = "red")

#' ## Saving Data

#' ### Make sure your working directory is set correctly!
slots <- read.delim("./data/slots.txt", sep = " ", header = F,
                    stringsAsFactors = F)
names(slots) <- c("w1", "w2", "w3", "prize", "night")
levels <- c(0, 1, 2, 3, 5, 6, 7)
labels <- c("0", "B", "BB", "BBB", "DD", "C", "7")
slots$w1 <- factor(slots$w1, levels = levels, labels = labels)
slots$w2 <- factor(slots$w2, levels = levels, labels = labels)
slots$w3 <- factor(slots$w3, levels = levels, labels = labels)

#' ### How to save work
write.csv(slots, "slots-2.csv")
slots2 <- read.csv("slots-2.csv")
head(slots)
head(slots2)
str(slots)
str(slots2)

#' ### Better, but still loses factor levels
write.csv(slots, file = "slots-3.csv", row.names = F)
slots3 <- read.csv("slots-3.csv")
head(slots)
head(slots3)
str(slots)
str(slots3)

#' ### For long-term storage
write.csv(slots, file = "slots.csv",
          row.names = FALSE)
#' ### For short-term caching
#' Preserves factors etc.
saveRDS(slots, "slots.rds")
slots2 <- readRDS("slots.rds")
head(slots2)
str(slots2)

#' ## Slot Machine Payoffs
#' Casino claims that slot machines have prize payout of 92%. Is this claim true?
mean(slots$prize)
t.test(slots$prize, mu = 0.92)
qplot(prize, data = slots, binwidth = 1)
#'#### How can we do better?

#' ### # Challenge: given e.g.
windows <- c("7", "C", "C")
#" how can we calculate thepayoff in R?

#' ### Using Conditionals to check all cases
x <- 5
if (x < 5) print("x < 5")
if (x == 5) print("x == 5")
x <- 1:5
if (x < 3) print("What should happen here?")
if (x[1] < x[2]) print("x1 < x2")
if (x[1] < x[2] && x[2] < x[3]) print("Asc")
if (x[1] < x[2] || x[2] < x[3]) print("Asc")

if (windows[1] == "DD") {
  prize <- 800
} else if (windows[1] == "7") {
  prize <- 80
} else if (windows[1] == "BBB") { 
  print("end")
}

#' #### Or use subsetting
c("DD" = 800, "7" = 80, "BBB" = 40)
c("DD" = 800, "7" = 80, "BBB" = 40)["BBB"]
c("DD" = 800, "7" = 80, "BBB" = 40)["0"]
c("DD" = 800, "7" = 80, "BBB" = 40)[windows[1]]

windows[1] %in% c("B", "BB", "BBB")
windows %in% c("B", "BB", "BBB")
allbars <- windows %in% c("B", "BB", "BBB")
allbars[1] & allbars[2] & allbars[3]
all(allbars)

#' ### Exercise
#'  Complete the previous code so that the correct value of prize is set if all the
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
prize


#' Need numbers of cherries, and numbers
#' of diamonds (hint: use sum)
#' Then need to look up values (like for the
#' first case) and multiply together
cherries <- sum(windows == "C")
diamonds <- sum(windows == "DD")
c(0, 2, 5)[cherries + 1] *
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
