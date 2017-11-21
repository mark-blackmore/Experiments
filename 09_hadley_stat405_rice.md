Lecture 9: Functions & for loops
================
Mark Blackmore
2017-11-20

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

    ## [1] 0.09735204

Steps

``` r
n <- length(x)
xbar <- mean(x)
x - xbar
```

    ##   [1]  0.05819820 -0.08735305 -0.32111010  0.18490020 -0.01160699
    ##   [6] -0.24366964  0.44364228 -0.32491030 -0.30253810  0.07407932
    ##  [11] -0.40916057  0.44302498 -0.25355838 -0.18585736 -0.46832228
    ##  [16]  0.20618635  0.39587764  0.18672035 -0.05375903  0.41848124
    ##  [21]  0.06066142  0.29827430  0.21985009 -0.04496081  0.01657525
    ##  [26] -0.27133783  0.01859336 -0.46192350 -0.46848861 -0.20685653
    ##  [31]  0.22184269  0.02251898  0.12111164  0.13894258 -0.23985554
    ##  [36]  0.34497456  0.26732813 -0.23486789  0.47047373 -0.33709897
    ##  [41] -0.25861447 -0.09402579 -0.14708947  0.41886532  0.28763601
    ##  [46] -0.22462200 -0.30730488  0.32580089  0.05941742  0.45736223
    ##  [51]  0.47447957  0.37106426 -0.34532262  0.49115562  0.26864001
    ##  [56] -0.46618422  0.39388460 -0.49291300  0.38907027  0.04477617
    ##  [61]  0.19112743  0.08823230 -0.49182469  0.38138478  0.11449234
    ##  [66]  0.11812143  0.45704279  0.38713035 -0.27773838  0.45429712
    ##  [71] -0.07398589 -0.01283707 -0.45588351 -0.38811267  0.39511222
    ##  [76]  0.40876899 -0.38137110 -0.44527687 -0.34664563 -0.27949518
    ##  [81]  0.10216773  0.47949765 -0.14139086 -0.06030167  0.33614897
    ##  [86] -0.37114148 -0.09999400  0.35169666 -0.06692359 -0.40029372
    ##  [91] -0.35215360  0.16872909 -0.47853248 -0.24199240 -0.38261073
    ##  [96] -0.19623775 -0.32788018  0.09780475  0.49554102 -0.08576995

``` r
(x - xbar) ^ 2
```

    ##   [1] 0.0033870306 0.0076305561 0.1031116964 0.0341880844 0.0001347222
    ##   [6] 0.0593748953 0.1968184760 0.1055666999 0.0915293003 0.0054877453
    ##  [11] 0.1674123697 0.1962711352 0.0642918506 0.0345429583 0.2193257591
    ##  [16] 0.0425128124 0.1567191030 0.0348644872 0.0028900333 0.1751265516
    ##  [21] 0.0036798076 0.0889675567 0.0483340635 0.0020214745 0.0002747389
    ##  [26] 0.0736242198 0.0003457131 0.2133733177 0.2194815745 0.0427896235
    ##  [31] 0.0492141776 0.0005071044 0.0146680305 0.0193050415 0.0575306809
    ##  [36] 0.1190074439 0.0714643308 0.0551629239 0.2213455327 0.1136357187
    ##  [41] 0.0668814430 0.0088408490 0.0216353126 0.1754481525 0.0827344760
    ##  [46] 0.0504550442 0.0944362902 0.1061462200 0.0035304303 0.2091802135
    ##  [51] 0.2251308589 0.1376886871 0.1192477093 0.2412338479 0.0721674538
    ##  [56] 0.2173277233 0.1551450805 0.2429632207 0.1513756712 0.0020049055
    ##  [61] 0.0365296961 0.0077849380 0.2418915291 0.1454543538 0.0131084955
    ##  [66] 0.0139526724 0.2088881132 0.1498699075 0.0771386080 0.2063858741
    ##  [71] 0.0054739114 0.0001647903 0.2078297729 0.1506314433 0.1561136637
    ##  [76] 0.1670920871 0.1454439181 0.1982714902 0.1201631918 0.0781175584
    ##  [81] 0.0104382460 0.2299179975 0.0199913759 0.0036362908 0.1129961312
    ##  [86] 0.1377460001 0.0099988003 0.1236905412 0.0044787672 0.1602350653
    ##  [91] 0.1240121581 0.0284695062 0.2289933304 0.0585603210 0.1463909743
    ##  [96] 0.0385092532 0.1075054113 0.0095657690 0.2455609059 0.0073564841

``` r
sum(x - xbar) ^ 2
```

    ## [1] 1.972152e-29

``` r
sum((x - xbar) ^ 2)
```

    ## [1] 9.637852

``` r
sum((x - xbar) ^ 2) / n - 1
```

    ## [1] -0.9036215

``` r
sum((x - xbar) ^ 2) / (n - 1) 
```

    ## [1] 0.09735204

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
