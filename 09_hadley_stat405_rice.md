Lecture 9 for Hadley Wickham's STAT 405 at Rice U. Functions $ for loops
================
Mark Blackmore
2017-10-01

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

    ## [1] 0.0816041

Steps

``` r
n <- length(x)
xbar <- mean(x)
x - xbar
```

    ##   [1]  0.308650967 -0.273855693  0.445645373  0.364867206 -0.012850539
    ##   [6]  0.418251098 -0.357818443  0.017537387 -0.086007136 -0.435363801
    ##  [11] -0.447163157 -0.089997509 -0.107443747  0.352539448 -0.302367206
    ##  [16] -0.169259645  0.127742644  0.277518482  0.221543024 -0.385299693
    ##  [21] -0.319835878  0.240685663  0.393880533  0.482763228  0.235257050
    ##  [26] -0.021335111  0.321059492  0.389371629  0.419831526 -0.452746406
    ##  [31]  0.276617731  0.031471758 -0.237906388 -0.372470366 -0.293763387
    ##  [36] -0.457596003 -0.197634567  0.069536449  0.257166741  0.219551739
    ##  [41]  0.408472775 -0.332913551  0.106770557 -0.222184579  0.288315984
    ##  [46] -0.443055902  0.080822464 -0.317465547 -0.289418356  0.213885605
    ##  [51]  0.213555646 -0.208031601  0.239231461 -0.322568720 -0.262138330
    ##  [56] -0.434126161 -0.138002703  0.369032110  0.118198080  0.077058805
    ##  [61]  0.107597449  0.086423252 -0.005455928  0.069432959 -0.297295301
    ##  [66] -0.184670747 -0.235390115  0.136165393  0.349262042  0.069272222
    ##  [71] -0.002693819  0.220233720  0.133335626 -0.105921472 -0.073926420
    ##  [76] -0.004176066  0.438703175 -0.116682261  0.456187427  0.448379839
    ##  [81] -0.181890684 -0.170899365 -0.268899180  0.016530177 -0.418856358
    ##  [86]  0.020962303 -0.255308790 -0.258594505  0.314138287  0.463684675
    ##  [91] -0.280528630 -0.355586615  0.373112838 -0.297956421 -0.068421861
    ##  [96] -0.418915858  0.421909545  0.318613319 -0.335004836 -0.103081542

``` r
(x - xbar) ^ 2
```

    ##   [1] 9.526542e-02 7.499694e-02 1.985998e-01 1.331281e-01 1.651364e-04
    ##   [6] 1.749340e-01 1.280340e-01 3.075599e-04 7.397228e-03 1.895416e-01
    ##  [11] 1.999549e-01 8.099552e-03 1.154416e-02 1.242841e-01 9.142593e-02
    ##  [16] 2.864883e-02 1.631818e-02 7.701651e-02 4.908131e-02 1.484559e-01
    ##  [21] 1.022950e-01 5.792959e-02 1.551419e-01 2.330603e-01 5.534588e-02
    ##  [26] 4.551870e-04 1.030792e-01 1.516103e-01 1.762585e-01 2.049793e-01
    ##  [31] 7.651737e-02 9.904716e-04 5.659945e-02 1.387342e-01 8.629693e-02
    ##  [36] 2.093941e-01 3.905942e-02 4.835318e-03 6.613473e-02 4.820297e-02
    ##  [41] 1.668500e-01 1.108314e-01 1.139995e-02 4.936599e-02 8.312611e-02
    ##  [46] 1.962985e-01 6.532271e-03 1.007844e-01 8.376299e-02 4.574705e-02
    ##  [51] 4.560601e-02 4.327715e-02 5.723169e-02 1.040506e-01 6.871650e-02
    ##  [56] 1.884655e-01 1.904475e-02 1.361847e-01 1.397079e-02 5.938059e-03
    ##  [61] 1.157721e-02 7.468979e-03 2.976715e-05 4.820936e-03 8.838450e-02
    ##  [66] 3.410328e-02 5.540851e-02 1.854101e-02 1.219840e-01 4.798641e-03
    ##  [71] 7.256661e-06 4.850289e-02 1.777839e-02 1.121936e-02 5.465116e-03
    ##  [76] 1.743952e-05 1.924605e-01 1.361475e-02 2.081070e-01 2.010445e-01
    ##  [81] 3.308422e-02 2.920659e-02 7.230677e-02 2.732467e-04 1.754406e-01
    ##  [86] 4.394182e-04 6.518258e-02 6.687112e-02 9.868286e-02 2.150035e-01
    ##  [91] 7.869631e-02 1.264418e-01 1.392132e-01 8.877803e-02 4.681551e-03
    ##  [96] 1.754905e-01 1.780077e-01 1.015144e-01 1.122282e-01 1.062580e-02

``` r
sum(x - xbar) ^ 2
```

    ## [1] 2.386304e-29

``` r
sum((x - xbar) ^ 2)
```

    ## [1] 8.078806

``` r
sum((x - xbar) ^ 2) / n - 1
```

    ## [1] -0.9192119

``` r
sum((x - xbar) ^ 2) / (n - 1) 
```

    ## [1] 0.0816041

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
