Lecture 8 for Hadley Wickham's STAT 405 at Rice U. Functions $ for loops
================
Mark Blackmore
2017-09-25

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
}
```

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

    ## [1] 0.08325885

Steps

``` r
n <- length(x)
xbar <- mean(x)
x - xbar
```

    ##   [1] -0.181644905 -0.427107452 -0.132153903  0.009054253 -0.058369980
    ##   [6]  0.101155140 -0.207162807 -0.253502244 -0.065031567  0.497302879
    ##  [11]  0.472251948  0.334249248 -0.402341587  0.262204223  0.321559598
    ##  [16] -0.247166285 -0.254311537 -0.035620582  0.495819782 -0.005290250
    ##  [21] -0.255197903  0.377608402  0.432460704 -0.160368439  0.234077691
    ##  [26]  0.012965653 -0.415584879  0.089041392 -0.275630287 -0.035633919
    ##  [31]  0.017509220 -0.413216617  0.294564522 -0.109294775 -0.313378342
    ##  [36]  0.111303497 -0.005465856 -0.455003511 -0.147110755  0.302522832
    ##  [41]  0.408700683  0.148134675 -0.307335157 -0.189611652  0.164028157
    ##  [46] -0.130893306  0.087388633  0.473622078  0.461696624  0.214223752
    ##  [51] -0.353038770 -0.408243595 -0.158088524  0.151637345  0.458121880
    ##  [56] -0.391137992 -0.179474106 -0.161855329 -0.381253409  0.319177756
    ##  [61]  0.308856191 -0.230466849  0.122103878  0.256994544 -0.204768030
    ##  [66]  0.446147584 -0.124762193  0.041196095  0.209268640 -0.251711639
    ##  [71]  0.245257316  0.388376674  0.044789186  0.267559603  0.146747946
    ##  [76]  0.394742482  0.440118063 -0.260115459 -0.306821823 -0.297352011
    ##  [81]  0.245299374 -0.368787949  0.385916176 -0.394383849  0.011302163
    ##  [86]  0.062146844  0.103780521  0.015359021 -0.479812341 -0.273106345
    ##  [91]  0.190765729  0.030800626  0.165163345 -0.476560894 -0.189289333
    ##  [96] -0.462331552  0.419445976  0.223827484 -0.146007941 -0.435549600

``` r
(x - xbar) ^ 2
```

    ##   [1] 3.299487e-02 1.824208e-01 1.746465e-02 8.197951e-05 3.407055e-03
    ##   [6] 1.023236e-02 4.291643e-02 6.426339e-02 4.229105e-03 2.473102e-01
    ##  [11] 2.230219e-01 1.117226e-01 1.618788e-01 6.875105e-02 1.034006e-01
    ##  [16] 6.109117e-02 6.467436e-02 1.268826e-03 2.458373e-01 2.798674e-05
    ##  [21] 6.512597e-02 1.425881e-01 1.870223e-01 2.571804e-02 5.479237e-02
    ##  [26] 1.681082e-04 1.727108e-01 7.928369e-03 7.597206e-02 1.269776e-03
    ##  [31] 3.065728e-04 1.707480e-01 8.676826e-02 1.194535e-02 9.820599e-02
    ##  [36] 1.238847e-02 2.987558e-05 2.070282e-01 2.164157e-02 9.152006e-02
    ##  [41] 1.670362e-01 2.194388e-02 9.445490e-02 3.595258e-02 2.690524e-02
    ##  [46] 1.713306e-02 7.636773e-03 2.243179e-01 2.131638e-01 4.589182e-02
    ##  [51] 1.246364e-01 1.666628e-01 2.499198e-02 2.299388e-02 2.098757e-01
    ##  [56] 1.529889e-01 3.221095e-02 2.619715e-02 1.453542e-01 1.018744e-01
    ##  [61] 9.539215e-02 5.311497e-02 1.490936e-02 6.604620e-02 4.192995e-02
    ##  [66] 1.990477e-01 1.556560e-02 1.697118e-03 4.379336e-02 6.335875e-02
    ##  [71] 6.015115e-02 1.508364e-01 2.006071e-03 7.158814e-02 2.153496e-02
    ##  [76] 1.558216e-01 1.937039e-01 6.766005e-02 9.413963e-02 8.841822e-02
    ##  [81] 6.017178e-02 1.360046e-01 1.489313e-01 1.555386e-01 1.277389e-04
    ##  [86] 3.862230e-03 1.077040e-02 2.358995e-04 2.302199e-01 7.458708e-02
    ##  [91] 3.639156e-02 9.486786e-04 2.727893e-02 2.271103e-01 3.583045e-02
    ##  [96] 2.137505e-01 1.759349e-01 5.009874e-02 2.131832e-02 1.897035e-01

``` r
sum(x - xbar) ^ 2
```

    ## [1] 7.099748e-30

``` r
sum((x - xbar) ^ 2)
```

    ## [1] 8.242626

``` r
sum((x - xbar) ^ 2) / n - 1
```

    ## [1] -0.9175737

``` r
sum((x - xbar) ^ 2) / (n - 1) 
```

    ## [1] 0.08325885

Wrap it Up

``` r
my_var <- function(x) {
  n <- length(x)
  xbar <- mean(x)
  sum((x - xbar) ^ 2) / (n - 1)
}
```

Clean Up

``` r
rm(list = ls())
```

For Loops
---------

``` r
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
