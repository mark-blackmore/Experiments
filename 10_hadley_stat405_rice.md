Lecture 10 for Hadley Wickham's STAT 405 at Rice U. Simulation
================
Mark Blackmore
2017-09-26

For Loops
---------

Common pattern: create object for output, then fill with results
================================================================

``` r
library(ggplot2)
cuts <- levels(diamonds$cut)
means <- rep(NA, length(cuts))
for(i in seq_along(cuts)) {
  sub <- diamonds[diamonds$cut == cuts[i], ]
  means[i] <- mean(sub$price)
}
```

We will learn more sophisticated ways to do this later on, but this is the most explicit
