Lecture 9 for Hadley Wickham's STAT 405 at Rice U. Functions $ for loops
================
Mark Blackmore
2017-09-29

Slots Strategy
--------------

How can we determine if all of the windows are B, BB, or BBB?

``` r
windows <- c("7", "C", "C") 
windows[1] %in% c("B", "BB", "BBB")
```

    ## [1] FALSE

``` r
windows %in% c("B", "BB", "BBB")
```

    ## [1] FALSE FALSE FALSE

``` r
allbars <- windows %in% c("B", "BB", "BBB")
allbars[1] & allbars[2] & allbars[3]
```

    ## [1] FALSE

``` r
all(allbars)
```

    ## [1] FALSE

Complete the previous code so that the correct value of prize is set if all the windows are the same, or they are all bars

``` r
payoffs <- c("DD" = 800, "7" = 80, "BBB" = 40,
             "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
same <- length(unique(windows)) == 1
allbars <- all(windows %in% c("B", "BB", "BBB"))
if (same) {
  prize <- payoffs[windows[1]]
} else if (allbars) {
  prize <- 5
}
```

Need numbers of cherries, and numbers of diamonds (hint: use sum) Then need to look up values (like for the first case) and multiply together

``` r
cherries <- sum(windows == "C")
diamonds <- sum(windows == "DD")
c(0, 2, 5)[cherries + 1]  *
  c(1, 2, 4)[diamonds + 1]
```

    ## [1] 5

``` r
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
```

    ## [1] 5

Writing a Function
------------------

Now we need to wrap up this code into a reusable tool. We need a function. We've used functions a lot, and now it's time to learn how to write one.

### What We Want

``` r
# calculate_prize(c("DD", "DD", "DD"))
# calculate_prize(c("B", "BBB", "BB"))
# calculate_prize(c("B", "7", "C"))

calculate_prize <- function(windows) {
  prize <- NA 
  payoffs <- c("DD" = 800, "7" = 80, "BBB" = 40,
               "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
  same <- length(unique(windows)) == 1
  allbars <- all(windows %in% c("B", "BB", "BBB"))
  if (same) {
    prize <- unname(payoffs[windows[1]]) 
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

calculate_prize(c("DD", "DD", "DD"))
```

    ## [1] 800

``` r
calculate_prize(c("B", "BBB", "BB"))
```

    ## [1] 5

``` r
calculate_prize(c("B", "7", "C"))
```

    ## [1] 2

### Functions: Default values

``` r
mean <- function(x) {
  sum(x) / length(x)
}
mean(1:10)
```

    ## [1] 5.5

``` r
mean <- function(x, na.rm = FALSE) {
  if (na.rm) x <- x[!is.na(x)]
  sum(x) / length(x)
}
mean(c(NA, 1:9))
```

    ## [1] NA

``` r
mean(c(NA, 1:9), na.rm = FALSE)
```

    ## [1] NA

``` r
mean(c(NA, 1:9), na.rm = TRUE)
```

    ## [1] 5

### Exercise: Create Function to Compute Sample Variance

Start simple; use test values; check steps; wrap it up Test Values

``` r
x <- runif(100)
var(x)
```

    ## [1] 0.07194256

Steps

``` r
n <- length(x)
xbar <- mean(x)
x - xbar
```

    ##   [1] -0.217031893  0.083750679 -0.357655093  0.330997429 -0.123433996
    ##   [6] -0.012538289  0.359277866 -0.168703586 -0.476003063 -0.097547174
    ##  [11] -0.221720877 -0.435479919  0.352761823  0.224838326 -0.251387904
    ##  [16]  0.262609906 -0.382631658 -0.240796600  0.360977746 -0.117541330
    ##  [21]  0.203038845 -0.561097191  0.091808103  0.146401298 -0.464597665
    ##  [26] -0.136606062 -0.194683050  0.342608988 -0.362198002  0.202830016
    ##  [31] -0.469429094 -0.355627686  0.344702880 -0.109317559  0.242419303
    ##  [36]  0.383116023 -0.085359826  0.336982855 -0.328382071  0.143469069
    ##  [41]  0.287663683  0.024123954 -0.466397734  0.385928627  0.009753046
    ##  [46]  0.324906588 -0.240600146  0.233903636  0.112214382  0.346257389
    ##  [51] -0.514430030  0.361272192  0.132198252  0.336142158  0.006365580
    ##  [56] -0.114345714 -0.347497356  0.212125392 -0.215999676 -0.231512120
    ##  [61] -0.318152049  0.273990722  0.246306858  0.117382240 -0.249648477
    ##  [66] -0.105866604 -0.110485855 -0.089767088  0.250618618 -0.158774587
    ##  [71]  0.305882364 -0.046686897 -0.113677908 -0.057542364  0.366748630
    ##  [76]  0.288651315  0.126552640  0.221790526 -0.110279286  0.295568498
    ##  [81]  0.384337919  0.034042018 -0.267911550  0.022996240  0.076866558
    ##  [86]  0.266266720  0.065597720 -0.312513351  0.085482258  0.299895583
    ##  [91]  0.092660326 -0.383352251  0.341716907 -0.005570427 -0.258294146
    ##  [96] -0.269046735 -0.148607848  0.004777734 -0.325540272  0.278691630

``` r
(x - xbar) ^ 2
```

    ##   [1] 4.710284e-02 7.014176e-03 1.279172e-01 1.095593e-01 1.523595e-02
    ##   [6] 1.572087e-04 1.290806e-01 2.846090e-02 2.265789e-01 9.515451e-03
    ##  [11] 4.916015e-02 1.896428e-01 1.244409e-01 5.055227e-02 6.319588e-02
    ##  [16] 6.896396e-02 1.464070e-01 5.798300e-02 1.303049e-01 1.381596e-02
    ##  [21] 4.122477e-02 3.148301e-01 8.428728e-03 2.143334e-02 2.158510e-01
    ##  [26] 1.866122e-02 3.790149e-02 1.173809e-01 1.311874e-01 4.114002e-02
    ##  [31] 2.203637e-01 1.264711e-01 1.188201e-01 1.195033e-02 5.876712e-02
    ##  [36] 1.467779e-01 7.286300e-03 1.135574e-01 1.078348e-01 2.058337e-02
    ##  [41] 8.275039e-02 5.819651e-04 2.175268e-01 1.489409e-01 9.512190e-05
    ##  [46] 1.055643e-01 5.788843e-02 5.471091e-02 1.259207e-02 1.198942e-01
    ##  [51] 2.646383e-01 1.305176e-01 1.747638e-02 1.129916e-01 4.052060e-05
    ##  [56] 1.307494e-02 1.207544e-01 4.499718e-02 4.665586e-02 5.359786e-02
    ##  [61] 1.012207e-01 7.507092e-02 6.066707e-02 1.377859e-02 6.232436e-02
    ##  [66] 1.120774e-02 1.220712e-02 8.058130e-03 6.280969e-02 2.520937e-02
    ##  [71] 9.356402e-02 2.179666e-03 1.292267e-02 3.311124e-03 1.345046e-01
    ##  [76] 8.331958e-02 1.601557e-02 4.919104e-02 1.216152e-02 8.736074e-02
    ##  [81] 1.477156e-01 1.158859e-03 7.177660e-02 5.288271e-04 5.908468e-03
    ##  [86] 7.089797e-02 4.303061e-03 9.766459e-02 7.307216e-03 8.993736e-02
    ##  [91] 8.585936e-03 1.469589e-01 1.167704e-01 3.102966e-05 6.671587e-02
    ##  [96] 7.238615e-02 2.208429e-02 2.282674e-05 1.059765e-01 7.766902e-02

``` r
sum(x - xbar) ^ 2
```

    ## [1] 1.262177e-29

``` r
sum((x - xbar) ^ 2)
```

    ## [1] 7.122314

``` r
sum((x - xbar) ^ 2) / n - 1
```

    ## [1] -0.9287769

``` r
sum((x - xbar) ^ 2) / (n - 1) 
```

    ## [1] 0.07194256

Wrap it Up

``` r
my_var <- function(x) {
  n <- length(x)
  xbar <- mean(x)
  sum((x - xbar) ^ 2) / (n - 1)
}
```

For Loops
---------

``` r
rm("diamonds")  
library(ggplot2)
cuts <- levels(diamonds$cut)
for(cut in cuts) {
  selected <- diamonds$price[diamonds$cut == cut]
  print(cut)
  print(mean(selected))
}
```

    ## [1] "Fair"
    ## [1] 4358.758
    ## [1] "Good"
    ## [1] 3928.864
    ## [1] "Very Good"
    ## [1] 3981.76
    ## [1] "Premium"
    ## [1] 4584.258
    ## [1] "Ideal"
    ## [1] 3457.542

Have to do something with output!

### Common pattern: create object for output, then fill with results

``` r
cuts <- levels(diamonds$cut)
means <- rep(NA, length(cuts))
for(i in seq_along(cuts)) {
  sub <- diamonds[diamonds$cut == cuts[i], ]
  means[i] <- mean(sub$price)
}
```

We will learn more sophisticated ways to do this later on, but this is the most explicit

``` r
1:5 
```

    ## [1] 1 2 3 4 5

``` r
seq_len(5)
```

    ## [1] 1 2 3 4 5

``` r
1:10
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
seq_len(10)
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
1:0
```

    ## [1] 1 0

``` r
seq_len(0)
```

    ## integer(0)

``` r
seq_along(1:10)
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
1:10 * 2
```

    ##  [1]  2  4  6  8 10 12 14 16 18 20

``` r
seq_along(1:10 * 2)
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

### Exercise

For each diamond colour, calculate the median price and carat size

``` r
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
```

| colours |  mprice|  mcarat|
|:--------|-------:|-------:|
| D       |  1838.0|    0.53|
| E       |  1739.0|    0.53|
| F       |  2343.5|    0.70|
| G       |  2242.0|    0.70|
| H       |  3460.0|    0.90|
| I       |  3730.0|    1.00|
| J       |  4234.0|    1.11|

Back to slots...
----------------

For each row, calculate the prize and save it, then compare calculated prize to actual prize.

Question: given a row, how can we extract the slots in the right form for the function?

### Recall: Loss of factor levels

``` r
slots <- read.csv("./data/slots.csv")
str(slots)
```

    ## 'data.frame':    345 obs. of  5 variables:
    ##  $ w1   : Factor w/ 7 levels "0","7","B","BB",..: 4 1 1 4 1 1 3 1 3 1 ...
    ##  $ w2   : Factor w/ 7 levels "0","7","B","BB",..: 1 7 1 1 1 1 1 1 4 1 ...
    ##  $ w3   : Factor w/ 7 levels "0","7","B","BB",..: 1 3 1 1 1 3 3 1 3 3 ...
    ##  $ prize: int  0 0 0 0 0 0 0 0 5 0 ...
    ##  $ night: int  1 1 1 1 1 1 1 1 1 1 ...

``` r
i <- 334
slots[i, ]
```

    ##     w1 w2 w3 prize night
    ## 334  B BB  B     5     2

``` r
slots[i, 1:3]
```

    ##     w1 w2 w3
    ## 334  B BB  B

``` r
str(slots[i, 1:3])
```

    ## 'data.frame':    1 obs. of  3 variables:
    ##  $ w1: Factor w/ 7 levels "0","7","B","BB",..: 3
    ##  $ w2: Factor w/ 7 levels "0","7","B","BB",..: 4
    ##  $ w3: Factor w/ 7 levels "0","7","B","BB",..: 3

``` r
as.character(slots[i, 1:3])
```

    ## [1] "3" "4" "3"

``` r
c(as.character(slots[i, 1]), as.character(slots[i, 2]),
  as.character(slots[i, 3])) 
```

    ## [1] "B"  "BB" "B"

### Recall: soloution to this issue

``` r
slots <- read.csv("./data/slots.csv", stringsAsFactors = F)
str(slots[i, 1:3])
```

    ## 'data.frame':    1 obs. of  3 variables:
    ##  $ w1: chr "B"
    ##  $ w2: chr "BB"
    ##  $ w3: chr "B"

``` r
as.character(slots[i, 1:3])
```

    ## [1] "B"  "BB" "B"

``` r
calculate_prize(as.character(slots[i, 1:3]))
```

    ## [1] 5

### Create space to put the results

``` r
slots$check <- NA
```

For each row, calculate the prize

``` r
for(i in seq_len(nrow(slots))) {
  w <- as.character(slots[i, 1:3])
  slots$check[i] <- calculate_prize(w)
}
```

### Check with known answers

``` r
subset(slots, prize != check)
```

    ##     w1 w2 w3 prize night check
    ## 139  C  0 DD    10     2     4
    ## 168  B BB DD    10     2     0
    ## 191  B  B DD    20     2     0
    ## 247  B DD  B    20     2     0
    ## 294  B DD  B    20     2     0
    ## 312  B DD  B    20     2     0
    ## 345  C  0  0     0     2     2

Uh oh! Check doesn't match known answers!
