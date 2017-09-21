Lecture 7 for Hadley Wickham's STAT 405 at Rice U. More About Data
================
Mark Blackmore
2017-09-20

``` r
library(ggplot2)
library(plyr)
```

Tips
----

If you know what the missing code is, use it

``` r
# read.csv(file, na.string = ".")
# read.csv(file, na.string = "-99")
```

Use count.fields to check the number of columns in each row. The following call uses the same default as read.csv

``` r
# count.fields(file, sep = ",",
#             quote = "", comment.char = "")
```

Exercise: downloading tricky files
----------------------------------

File URL's

``` r
fileUrl_1 <- "http://stat405.had.co.nz/data/tricky-1.csv"
fileUrl_2 <- "http://stat405.had.co.nz/data/tricky-2.csv"
fileUrl_3 <- "http://stat405.had.co.nz/data/tricky-3.csv"
fileUrl_4 <- "http://stat405.had.co.nz/data/tricky-4.csv"
```

Download files

``` r
download.file(fileUrl_1, destfile = "./data/tricky-1.csv")
download.file(fileUrl_2, destfile = "./data/tricky-2.csv")
download.file(fileUrl_3, destfile = "./data/tricky-3.csv")
download.file(fileUrl_4, destfile = "./data/tricky-4.csv")
list.files("./data")
```

    ## [1] "mpg2.csv.bz2" "slots.csv"    "slots.txt"    "tricky-1.csv"
    ## [5] "tricky-2.csv" "tricky-3.csv" "tricky-4.csv"

Load files into workspace

``` r
tricky_1 <- read.csv("./data/tricky-1.csv")
tricky_1
```

    ##      first      last                   address         city postcode
    ## 1     Leah     Downs           688-5741 Ut St.    Owensboro  V9Z 9K2
    ## 2    Boris     Kirby       257-5422 Vel Avenue       Rialto  C6I 9S0
    ## 3    Naida    Franco 809-5528 Tristique Avenue      Atwater  T8K 7U8
    ## 4     Xena    Tucker                7218 A St.  Grand Forks  M6O 1X4
    ## 5    Rylee      Wise       155-6070 Purus. St.     Bradford    65359
    ## 6   Baxter Gallagher          2415 Ligula. St.   Carbondale    55211
    ## 7  Griffin  Benjamin               3261 Ac St.      Guayama    94450
    ## 8    Rinah   Bradley      787-9626 Eget Avenue       Norton    17673
    ## 9   Tobias    Walter       4717 Mauris. Street    Attleboro    73678
    ## 10   Boris    Farley   893-8193 Quisque Avenue San Clemente    74492

``` r
tricky_2 <- read.csv("./data/tricky-2.csv", header = FALSE)
tricky_2
```

    ##         V1        V2                        V3           V4      V5
    ## 1     Leah     Downs           688-5741 Ut St.    Owensboro V9Z 9K2
    ## 2    Boris     Kirby       257-5422 Vel Avenue       Rialto C6I 9S0
    ## 3    Naida    Franco 809-5528 Tristique Avenue      Atwater T8K 7U8
    ## 4     Xena    Tucker                7218 A St.  Grand Forks M6O 1X4
    ## 5    Rylee      Wise       155-6070 Purus. St.     Bradford   65359
    ## 6   Baxter Gallagher          2415 Ligula. St.   Carbondale   55211
    ## 7  Griffin  Benjamin               3261 Ac St.      Guayama   94450
    ## 8    Rinah   Bradley      787-9626 Eget Avenue       Norton   17673
    ## 9   Tobias    Walter       4717 Mauris. Street    Attleboro   73678
    ## 10   Boris    Farley   893-8193 Quisque Avenue San Clemente   74492

``` r
tricky_3 <- read.delim("./data/tricky-3.csv", sep = "|")
tricky_3
```

    ##      first      last                   address         city postcode
    ## 1     Leah     Downs           688-5741 Ut St.    Owensboro  V9Z 9K2
    ## 2    Boris     Kirby       257-5422 Vel Avenue       Rialto  C6I 9S0
    ## 3    Naida    Franco 809-5528 Tristique Avenue      Atwater  T8K 7U8
    ## 4     Xena    Tucker                7218 A St.  Grand Forks  M6O 1X4
    ## 5    Rylee      Wise       155-6070 Purus. St.     Bradford    65359
    ## 6   Baxter Gallagher          2415 Ligula. St.   Carbondale    55211
    ## 7  Griffin  Benjamin               3261 Ac St.      Guayama    94450
    ## 8    Rinah   Bradley      787-9626 Eget Avenue       Norton    17673
    ## 9   Tobias    Walter       4717 Mauris. Street    Attleboro    73678
    ## 10   Boris    Farley   893-8193 Quisque Avenue San Clemente    74492

``` r
tricky_4 <- count.fields("./data/tricky-4.csv", sep = ",")
tricky_4
```

    ##  [1] 5 5 5 4 5 5 4 5 5 5 5

Exercise: clean slots.txt to look like slots.csv
------------------------------------------------

Start by examining the files using RStudio text editor
<br> File URL's

``` r
fileUrl_5 <- "http://stat405.had.co.nz/data/slots.txt"
fileUrl_6 <- "http://stat405.had.co.nz/data/slots.csv"
```

Data Cleaning
-------------

Goal: convert slots.txt to clean version - slots.csv Download files

``` r
download.file(fileUrl_5, destfile = "./data/slots.txt")
download.file(fileUrl_6, destfile = "./data/slots.csv")
```

Load files into workspace

``` r
count.fields("./data/slots.txt", sep = "",
             quote = "", comment.char = "")
```

    ##   [1] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
    ##  [36] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
    ##  [71] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
    ## [106] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
    ## [141] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
    ## [176] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
    ## [211] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
    ## [246] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
    ## [281] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
    ## [316] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5

``` r
slots <- read.delim("./data/slots.txt", sep = " ")
slots_clean <- read.csv("./data/slots.csv")
head(slots_clean)
```

    ##   w1 w2 w3 prize night
    ## 1 BB  0  0     0     1
    ## 2  0 DD  B     0     1
    ## 3  0  0  0     0     1
    ## 4 BB  0  0     0     1
    ## 5  0  0  0     0     1
    ## 6  0  0  B     0     1

### Variable Names

This is a very common pattern

``` r
names(slots)
```

    ## [1] "X2"   "X0"   "X0.1" "X0.2" "X1"

``` r
names(slots) <- c("w1", "w2", "w3",
                  "prize", "night")
dput(names(slots))
```

    ## c("w1", "w2", "w3", "prize", "night")

Strings and Factors
-------------------

By default, strings converted to factors when loading data frames. I think this is the wrong default - you should always explicitly convert strings to factors. Use stringsAsFactors = F to avoid this. For one data frame:

``` r
# read.csv("mpg.csv.bz2", stringsAsFactors = F)
```

For entire session:

``` r
# options(stringsAsFactors = F)
```

### Creating a factor

``` r
x <- sample(5, 20, rep = T)
a <- factor(x)
b <- factor(x, levels = 1:10)
c <- factor(x, labels = letters[1:5])
levels(a); levels(b); levels(c)
```

    ## [1] "1" "2" "3" "4" "5"

    ##  [1] "1"  "2"  "3"  "4"  "5"  "6"  "7"  "8"  "9"  "10"

    ## [1] "a" "b" "c" "d" "e"

``` r
table(a); table(b); table(c)
```

    ## a
    ## 1 2 3 4 5 
    ## 3 5 2 3 7

    ## b
    ##  1  2  3  4  5  6  7  8  9 10 
    ##  3  5  2  3  7  0  0  0  0  0

    ## c
    ## a b c d e 
    ## 3 5 2 3 7

### Create factors on slots data

``` r
slots <- read.delim("./data/slots.txt", sep = " ", header = F,
                    stringsAsFactors = F)
names(slots) <- c("w1", "w2", "w3", "prize", "night")
levels <- c(0, 1, 2, 3, 5, 6, 7)
labels <- c("0", "B", "BB", "BBB", "DD", "C", "7")
slots$w1 <- factor(slots$w1, levels = levels, labels = labels)
slots$w2 <- factor(slots$w2, levels = levels, labels = labels)
slots$w3 <- factor(slots$w3, levels = levels, labels = labels)
```
