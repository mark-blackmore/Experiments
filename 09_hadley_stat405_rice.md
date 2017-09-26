Lecture 9 for Hadley Wickham's STAT 405 at Rice U. Functions $ for loops
================
Mark Blackmore
2017-09-26

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

    ## [1] 0.0770652

Steps

``` r
n <- length(x)
xbar <- mean(x)
x - xbar
```

    ##   [1] -0.367561987 -0.087805820  0.065630184 -0.099824682 -0.373944688
    ##   [6]  0.494808762  0.004825117  0.117029707  0.217121153  0.518927952
    ##  [11] -0.347595302  0.368681314  0.159427172 -0.331696492 -0.037978881
    ##  [16] -0.280357744  0.215386138  0.065209226  0.196644732 -0.177075559
    ##  [21] -0.382799608  0.272391102 -0.358849277  0.243667927  0.223862444
    ##  [26] -0.262076884 -0.194612698 -0.340831755 -0.316742347 -0.369491401
    ##  [31]  0.329911432  0.130164312 -0.380841564 -0.129676695  0.076071371
    ##  [36]  0.264221453  0.347766527 -0.163529605 -0.352181329  0.314625815
    ##  [41]  0.029782576 -0.406177273 -0.280209229  0.075547786 -0.180826362
    ##  [46]  0.098839465  0.511503603  0.366762632  0.090548901 -0.178888415
    ##  [51]  0.353953655 -0.446509697  0.520663678 -0.315070370 -0.355334448
    ##  [56]  0.193018631 -0.461039018  0.189595700 -0.251356479 -0.082329264
    ##  [61] -0.424149044  0.249138778  0.111933557 -0.275984527  0.118911907
    ##  [66]  0.363438077 -0.204315789 -0.140459055  0.033619446  0.022865698
    ##  [71] -0.165891941  0.204273537  0.046793662 -0.034009571 -0.135408188
    ##  [76]  0.129826056  0.347611319 -0.039203056 -0.034044673 -0.033346767
    ##  [81]  0.036120038 -0.134894529 -0.101240891  0.447317578  0.202716478
    ##  [86]  0.241050780  0.283634869  0.341623631 -0.092534595  0.312625455
    ##  [91] -0.351412447  0.520445812 -0.373970375  0.360070900 -0.370397286
    ##  [96] -0.445976266  0.411888952  0.055569144 -0.077071761 -0.150540510

``` r
(x - xbar) ^ 2
```

    ##   [1] 1.351018e-01 7.709862e-03 4.307321e-03 9.964967e-03 1.398346e-01
    ##   [6] 2.448357e-01 2.328176e-05 1.369595e-02 4.714160e-02 2.692862e-01
    ##  [11] 1.208225e-01 1.359259e-01 2.541702e-02 1.100226e-01 1.442395e-03
    ##  [16] 7.860046e-02 4.639119e-02 4.252243e-03 3.866915e-02 3.135575e-02
    ##  [21] 1.465355e-01 7.419691e-02 1.287728e-01 5.937406e-02 5.011439e-02
    ##  [26] 6.868429e-02 3.787410e-02 1.161663e-01 1.003257e-01 1.365239e-01
    ##  [31] 1.088416e-01 1.694275e-02 1.450403e-01 1.681605e-02 5.786853e-03
    ##  [36] 6.981298e-02 1.209416e-01 2.674193e-02 1.240317e-01 9.898940e-02
    ##  [41] 8.870019e-04 1.649800e-01 7.851721e-02 5.707468e-03 3.269817e-02
    ##  [46] 9.769240e-03 2.616359e-01 1.345148e-01 8.199103e-03 3.200107e-02
    ##  [51] 1.252832e-01 1.993709e-01 2.710907e-01 9.926934e-02 1.262626e-01
    ##  [56] 3.725619e-02 2.125570e-01 3.594653e-02 6.318008e-02 6.778108e-03
    ##  [61] 1.799024e-01 6.207013e-02 1.252912e-02 7.616746e-02 1.414004e-02
    ##  [66] 1.320872e-01 4.174494e-02 1.972875e-02 1.130267e-03 5.228401e-04
    ##  [71] 2.752014e-02 4.172768e-02 2.189647e-03 1.156651e-03 1.833538e-02
    ##  [76] 1.685480e-02 1.208336e-01 1.536880e-03 1.159040e-03 1.112007e-03
    ##  [81] 1.304657e-03 1.819653e-02 1.024972e-02 2.000930e-01 4.109397e-02
    ##  [86] 5.810548e-02 8.044874e-02 1.167067e-01 8.562651e-03 9.773468e-02
    ##  [91] 1.234907e-01 2.708638e-01 1.398538e-01 1.296511e-01 1.371941e-01
    ##  [96] 1.988948e-01 1.696525e-01 3.087930e-03 5.940056e-03 2.266245e-02

``` r
sum(x - xbar) ^ 2
```

    ## [1] 0

``` r
sum((x - xbar) ^ 2)
```

    ## [1] 7.629455

``` r
sum((x - xbar) ^ 2) / n - 1
```

    ## [1] -0.9237055

``` r
sum((x - xbar) ^ 2) / (n - 1) 
```

    ## [1] 0.0770652

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
