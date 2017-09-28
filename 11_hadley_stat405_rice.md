Lecture 11 for Hadley Wickham's STAT 405 Advanced Data Manipulation
================
Mark Blackmore
2017-09-27

Baby names data
---------------

Top 1000 male and female baby names in the US, from 1880 to 2008.
258,000 records (1000 \* 2 \* 129) But only five variables: year, name, soundex, sex and prop.

``` r
file_bnames <- "http://stat405.had.co.nz/data/bnames2.csv.bz2"
file_births <- "http://stat405.had.co.nz/data/births.csv" 

library(plyr)
library(ggplot2)
options(stringsAsFactors = FALSE)
download.file(file_bnames, destfile = "./data/bnames2.csv.bz2")
download.file(file_births, destfile = "./data/births.csv")
bnames <- read.csv("./data/bnames2.csv.bz2")
births <- read.csv("./data/births.csv")

head(bnames, 20)
```

    ##    year    name     prop sex soundex
    ## 1  1880    John 0.081541 boy    J500
    ## 2  1880 William 0.080511 boy    W450
    ## 3  1880   James 0.050057 boy    J520
    ## 4  1880 Charles 0.045167 boy    C642
    ## 5  1880  George 0.043292 boy    G620
    ## 6  1880   Frank 0.027380 boy    F652
    ## 7  1880  Joseph 0.022229 boy    J210
    ## 8  1880  Thomas 0.021401 boy    T520
    ## 9  1880   Henry 0.020641 boy    H560
    ## 10 1880  Robert 0.020404 boy    R163
    ## 11 1880  Edward 0.019965 boy    E363
    ## 12 1880   Harry 0.018175 boy    H600
    ## 13 1880  Walter 0.014822 boy    W436
    ## 14 1880  Arthur 0.013504 boy    A636
    ## 15 1880    Fred 0.013251 boy    F630
    ## 16 1880  Albert 0.012609 boy    A416
    ## 17 1880  Samuel 0.008648 boy    S540
    ## 18 1880   David 0.007339 boy    D130
    ## 19 1880   Louis 0.006993 boy    L200
    ## 20 1880     Joe 0.006174 boy    J000

``` r
tail(bnames, 20)
```

    ##        year     name     prop  sex soundex
    ## 257981 2008     Miya 0.000130 girl    M000
    ## 257982 2008     Rory 0.000130 girl    R600
    ## 257983 2008  Desirae 0.000130 girl    D260
    ## 257984 2008   Kianna 0.000130 girl    K500
    ## 257985 2008   Laurel 0.000130 girl    L640
    ## 257986 2008   Neveah 0.000130 girl    N100
    ## 257987 2008   Amaris 0.000129 girl    A562
    ## 257988 2008 Hadassah 0.000129 girl    H320
    ## 257989 2008    Dania 0.000129 girl    D500
    ## 257990 2008   Hailie 0.000129 girl    H400
    ## 257991 2008   Jamiya 0.000129 girl    J500
    ## 257992 2008    Kathy 0.000129 girl    K300
    ## 257993 2008   Laylah 0.000129 girl    L400
    ## 257994 2008     Riya 0.000129 girl    R000
    ## 257995 2008     Diya 0.000128 girl    D000
    ## 257996 2008 Carleigh 0.000128 girl    C642
    ## 257997 2008    Iyana 0.000128 girl    I500
    ## 257998 2008   Kenley 0.000127 girl    K540
    ## 257999 2008   Sloane 0.000127 girl    S450
    ## 258000 2008  Elianna 0.000127 girl    E450

### Exercise:

Extract your name from the dataset. Plot the trend over time. What geom should you use? Do you need any extra aesthetics?

``` r
mark <- subset(bnames, name == "Mark")
qplot(year, prop, data = mark, color = sex, geom = "line")
```

![](11_hadley_stat405_rice_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)

``` r
sheryl <- subset(bnames, name == "Sheryl")
qplot(year, prop, data = sheryl, geom = "line")
```

![](11_hadley_stat405_rice_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-2.png)

``` r
garrett <- subset(bnames, name == "garrett")
hadley <- subset(bnames, name == "Hadley")
qplot(year, prop, data = garrett, geom = "line")
```

![](11_hadley_stat405_rice_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-3.png)

``` r
qplot(year, prop, data = hadley, color = sex,
      geom = "line")
```

![](11_hadley_stat405_rice_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-4.png)

### Exercise:

Use the soundex variable to extract all names that sound like yours. Plot the trend over time.

``` r
mark_soundex <- subset(bnames, soundex == "M620")
qplot(year, prop, data = mark_soundex, color = name, group = sex, geom = "line")
```

![](11_hadley_stat405_rice_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

``` r
glike <- subset(bnames, soundex == "G630")
qplot(year, prop, data = glike)
```

![](11_hadley_stat405_rice_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-2.png)

``` r
qplot(year, prop, data = glike, geom = "line")
```

![](11_hadley_stat405_rice_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-3.png)

``` r
qplot(year, prop, data = glike, geom = "line",
      colour = sex)
```

![](11_hadley_stat405_rice_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-4.png)

``` r
qplot(year, prop, data = glike, geom = "line",
      colour = sex) + facet_wrap(~ name)
```

    ## geom_path: Each group consists of only one observation. Do you need to
    ## adjust the group aesthetic?

![](11_hadley_stat405_rice_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-5.png)

``` r
qplot(year, prop, data = glike, geom = "line",
      colour = sex, group = interaction(sex, name))
```

![](11_hadley_stat405_rice_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-6.png)

### Exercise

In which year was your name most popular? Least popular? Reorder the data frame containing your name from highest to lowest popularity. Add a new column that gives the number of babies per thousand with your name.

``` r
head(arrange(mark, desc(prop)),1)
```

    ##   year name     prop sex soundex
    ## 1 1960 Mark 0.027121 boy    M620

``` r
head(arrange(mark, prop),1)     
```

    ##   year name    prop  sex soundex
    ## 1 1958 Mark 5.5e-05 girl    M620

``` r
head(mutate(mark, per1000 = prop*1000))
```

    ##      year name     prop sex soundex per1000
    ## 160  1880 Mark 0.000726 boy    M620   0.726
    ## 1129 1881 Mark 0.000868 boy    M620   0.868
    ## 2155 1882 Mark 0.000737 boy    M620   0.737
    ## 3142 1883 Mark 0.000809 boy    M620   0.809
    ## 4144 1884 Mark 0.000782 boy    M620   0.782
    ## 5178 1885 Mark 0.000638 boy    M620   0.638

``` r
summarise(garrett,
          least = year[prop == min(prop)],
          most = year[prop == max(prop)])
```

    ## Warning in min(prop): no non-missing arguments to min; returning Inf

    ## Warning in max(prop): no non-missing arguments to max; returning -Inf

    ## [1] least most 
    ## <0 rows> (or 0-length row.names)

``` r
# OR
summarise(garrett,
          least = year[which.min(prop)],
          most = year[which.max(prop)])
```

    ## [1] least most 
    ## <0 rows> (or 0-length row.names)

``` r
head(arrange(garrett, desc(prop)))
```

    ## [1] year    name    prop    sex     soundex
    ## <0 rows> (or 0-length row.names)

``` r
head(mutate(garrett, per1000 = round(1000 * prop)))
```

    ## [1] year    name    prop    sex     soundex per1000
    ## <0 rows> (or 0-length row.names)

Merging Data
------------

``` r
library(knitr)
what_played<- data.frame(name = c("John", "Paul",
  "George", "Ringo", "Stuart", "Pete"), instrument =
  c("guitar", "bass", "guitar", "drums", "bass", "drums"))

members <- data.frame(name = c("John", "Paul",
  "George", "Ringo", "Brian"), band = c("TRUE",
  "TRUE", "TRUE", "TRUE", "FALSE")) 

kable(join(what_played, members, type = "left"))
```

    ## Joining by: name

| name   | instrument | band |
|:-------|:-----------|:-----|
| John   | guitar     | TRUE |
| Paul   | bass       | TRUE |
| George | guitar     | TRUE |
| Ringo  | drums      | TRUE |
| Stuart | bass       | NA   |
| Pete   | drums      | NA   |

``` r
kable(join(what_played, members, type = "right"))
```

    ## Joining by: name

| name   | instrument | band  |
|:-------|:-----------|:------|
| John   | guitar     | TRUE  |
| Paul   | bass       | TRUE  |
| George | guitar     | TRUE  |
| Ringo  | drums      | TRUE  |
| Brian  | NA         | FALSE |

``` r
kable(join(what_played, members, type = "inner"))
```

    ## Joining by: name

| name   | instrument | band |
|:-------|:-----------|:-----|
| John   | guitar     | TRUE |
| Paul   | bass       | TRUE |
| George | guitar     | TRUE |
| Ringo  | drums      | TRUE |

``` r
kable(join(what_played, members, type = "full"))
```

    ## Joining by: name

| name   | instrument | band  |
|:-------|:-----------|:------|
| John   | guitar     | TRUE  |
| Paul   | bass       | TRUE  |
| George | guitar     | TRUE  |
| Ringo  | drums      | TRUE  |
| Stuart | bass       | NA    |
| Pete   | drums      | NA    |
| Brian  | NA         | FALSE |

### Exercise

Convert from proportions to absolute numbers by combining bnames with births, and then performing the appropriate calculation.

``` r
head(bnames)
```

    ##   year    name     prop sex soundex
    ## 1 1880    John 0.081541 boy    J500
    ## 2 1880 William 0.080511 boy    W450
    ## 3 1880   James 0.050057 boy    J520
    ## 4 1880 Charles 0.045167 boy    C642
    ## 5 1880  George 0.043292 boy    G620
    ## 6 1880   Frank 0.027380 boy    F652

``` r
head(births)
```

    ##   year sex births
    ## 1 1880 boy 118405
    ## 2 1881 boy 108290
    ## 3 1882 boy 122034
    ## 4 1883 boy 112487
    ## 5 1884 boy 122745
    ## 6 1885 boy 115948

``` r
bnames2 <- join(bnames, births,
                by = c("year", "sex"))
tail(bnames2)
```

    ##        year     name     prop  sex soundex  births
    ## 257995 2008     Diya 0.000128 girl    D000 2072756
    ## 257996 2008 Carleigh 0.000128 girl    C642 2072756
    ## 257997 2008    Iyana 0.000128 girl    I500 2072756
    ## 257998 2008   Kenley 0.000127 girl    K540 2072756
    ## 257999 2008   Sloane 0.000127 girl    S450 2072756
    ## 258000 2008  Elianna 0.000127 girl    E450 2072756

``` r
bnames2 <- mutate(bnames2, n = prop * births)
tail(bnames2)
```

    ##        year     name     prop  sex soundex  births        n
    ## 257995 2008     Diya 0.000128 girl    D000 2072756 265.3128
    ## 257996 2008 Carleigh 0.000128 girl    C642 2072756 265.3128
    ## 257997 2008    Iyana 0.000128 girl    I500 2072756 265.3128
    ## 257998 2008   Kenley 0.000127 girl    K540 2072756 263.2400
    ## 257999 2008   Sloane 0.000127 girl    S450 2072756 263.2400
    ## 258000 2008  Elianna 0.000127 girl    E450 2072756 263.2400

``` r
bnames2 <- mutate(bnames2, n = round(prop * births))
tail(bnames2)
```

    ##        year     name     prop  sex soundex  births   n
    ## 257995 2008     Diya 0.000128 girl    D000 2072756 265
    ## 257996 2008 Carleigh 0.000128 girl    C642 2072756 265
    ## 257997 2008    Iyana 0.000128 girl    I500 2072756 265
    ## 257998 2008   Kenley 0.000127 girl    K540 2072756 263
    ## 257999 2008   Sloane 0.000127 girl    S450 2072756 263
    ## 258000 2008  Elianna 0.000127 girl    E450 2072756 263

``` r
head(arrange(bnames2, desc(n)))
```

    ##   year    name     prop  sex soundex  births     n
    ## 1 1947   Linda 0.054829 girl    L530 1817550 99654
    ## 2 1948   Linda 0.055203 girl    L530 1741506 96136
    ## 3 1947   James 0.050987  boy    J520 1855892 94626
    ## 4 1957 Michael 0.042392  boy    M240 2186874 92706
    ## 5 1947  Robert 0.049360  boy    R163 1855892 91607
    ## 6 1949   Linda 0.051835 girl    L530 1754263 90932

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:plyr':
    ## 
    ##     arrange, count, desc, failwith, id, mutate, rename, summarise,
    ##     summarize

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
bnames2 %>% filter(name == "Mark") %>% arrange(desc(n)) %>% head()
```

    ##   year name     prop sex soundex  births     n
    ## 1 1960 Mark 0.027121 boy    M620 2165791 58738
    ## 2 1961 Mark 0.026795 boy    M620 2154552 57731
    ## 3 1959 Mark 0.026277 boy    M620 2165866 56912
    ## 4 1962 Mark 0.025460 boy    M620 2101707 53509
    ## 5 1957 Mark 0.024137 boy    M620 2186874 52785
    ## 6 1958 Mark 0.024467 boy    M620 2152102 52655

Births database does not contain all births!

``` r
qplot(year, births, data = births, geom = "line",
      color = sex)
```

![](11_hadley_stat405_rice_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-7-1.png)

### Add to Beatles data. How could we combine what\_player & members now?

``` r
members$instrument <- c("vocals", "vocals", "backup",
                        "backup", "manager")

kable(what_played)
```

| name   | instrument |
|:-------|:-----------|
| John   | guitar     |
| Paul   | bass       |
| George | guitar     |
| Ringo  | drums      |
| Stuart | bass       |
| Pete   | drums      |

``` r
kable(members)
```

| name   | band  | instrument |
|:-------|:------|:-----------|
| John   | TRUE  | vocals     |
| Paul   | TRUE  | vocals     |
| George | TRUE  | backup     |
| Ringo  | TRUE  | backup     |
| Brian  | FALSE | manager    |

``` r
kable(join(what_played, members, type = "full"))
```

    ## Joining by: name, instrument

| name   | instrument | band  |
|:-------|:-----------|:------|
| John   | guitar     | NA    |
| Paul   | bass       | NA    |
| George | guitar     | NA    |
| Ringo  | drums      | NA    |
| Stuart | bass       | NA    |
| Pete   | drums      | NA    |
| John   | vocals     | TRUE  |
| Paul   | vocals     | TRUE  |
| George | backup     | TRUE  |
| Ringo  | backup     | TRUE  |
| Brian  | manager    | FALSE |

``` r
# :(

kable(join(what_played, members, by = "name", type = "full"))
```

| name   | instrument | band  |
|:-------|:-----------|:------|
| John   | guitar     | TRUE  |
| Paul   | bass       | TRUE  |
| George | guitar     | TRUE  |
| Ringo  | drums      | TRUE  |
| Stuart | bass       | NA    |
| Pete   | drums      | NA    |
| Brian  | manager    | FALSE |

``` r
# :(

names(members)[3] <- "instrument2"
kable(members)
```

| name   | band  | instrument2 |
|:-------|:------|:------------|
| John   | TRUE  | vocals      |
| Paul   | TRUE  | vocals      |
| George | TRUE  | backup      |
| Ringo  | TRUE  | backup      |
| Brian  | FALSE | manager     |

``` r
kable(join(what_played, members, type = "full"))
```

    ## Joining by: name

| name   | instrument | band  | instrument2 |
|:-------|:-----------|:------|:------------|
| John   | guitar     | TRUE  | vocals      |
| Paul   | bass       | TRUE  | vocals      |
| George | guitar     | TRUE  | backup      |
| Ringo  | drums      | TRUE  | backup      |
| Stuart | bass       | NA    | NA          |
| Pete   | drums      | NA    | NA          |
| Brian  | NA         | FALSE | manager     |

Groupwise Operations
--------------------

How do we compute the number of people with each name over all years ? It's pretty easy if you have a single name. (e.g. how many people with your name were born over the entire 128 years)

``` r
garrett <- subset(bnames2, name == "garrett")
sum(garrett$n)
```

    ## [1] 0

``` r
# Or
summarise(garrett, n = sum(n))
```

    ##   n
    ## 1 0

But how could we do this for every name? Split

``` r
pieces <- split(bnames2, list(bnames$name))
```

Apply

``` r
results <- vector("list", length(pieces))
for(i in seq_along(pieces)) {
  piece <- pieces[[i]]
  results[[i]] <- summarise(piece,
                            name = name[1], n = sum(n))
}
```

Combine

``` r
result <- do.call("rbind", results)
kable(head(result))
```

| name    |       n|
|:--------|-------:|
| Aaden   |     959|
| Aaliyah |   39665|
| Aarav   |     219|
| Aaron   |  509464|
| Ab      |      25|
| Abagail |    2682|

Or equivalently

``` r
counts <- ddply(bnames2, "name", summarise,
                n = sum(n))
kable(head(counts))
```

| name    |       n|
|:--------|-------:|
| Aaden   |     959|
| Aaliyah |   39665|
| Aarav   |     219|
| Aaron   |  509464|
| Ab      |      25|
| Abagail |    2682|

Or, using dplyr

``` r
count_pipe <- bnames2 %>% group_by(name) %>% summarise(n = sum(n))
kable(head(count_pipe))
```

| name    |       n|
|:--------|-------:|
| Aaden   |     959|
| Aaliyah |   39665|
| Aarav   |     219|
| Aaron   |  509464|
| Ab      |      25|
| Abagail |    2682|

### Exercise

Repeat the same operation, but use soundex instead of name. What is the most common sound? What name does it correspond to? (Hint: use join)

``` r
scounts <- ddply(bnames2, "soundex", summarise,
                 n = sum(n))
scounts <- arrange(scounts, desc(n))
kable(head(scounts))
```

| soundex |        n|
|:--------|--------:|
| J500    |  9991737|
| M240    |  5823791|
| M600    |  5553703|
| J520    |  5524958|
| R163    |  5047182|
| W450    |  4116109|

Combine with names. When there are multiple possible matches, picks first

``` r
scounts <- join(
  scounts, bnames2[, c("soundex", "name")],
  by = "soundex", match = "first")
kable(head(scounts, 10))
```

| soundex |        n| name        |
|:--------|--------:|:------------|
| J500    |  9991737| John        |
| M240    |  5823791| Michael     |
| M600    |  5553703| Mary        |
| J520    |  5524958| James       |
| R163    |  5047182| Robert      |
| W450    |  4116109| William     |
| C623    |  4016919| Christopher |
| J200    |  3859240| Jesse       |
| D500    |  3774287| Dan         |
| D130    |  3506995| David       |

``` r
subset(bnames, soundex == "L600")
```

    ##        year   name     prop  sex soundex
    ## 108    1880  Leroy 0.001047  boy    L600
    ## 513    1880  Larry 0.000110  boy    L600
    ## 999    1880 Lawyer 0.000042  boy    L600
    ## 1098   1881  Leroy 0.001191  boy    L600
    ## 1678   1881  Larry 0.000074  boy    L600
    ## 2096   1882  Leroy 0.001246  boy    L600
    ## 2730   1882  Larry 0.000066  boy    L600
    ## 2802   1882   Lora 0.000057  boy    L600
    ## 2900   1882 Lawyer 0.000049  boy    L600
    ## 3094   1883  Leroy 0.001271  boy    L600
    ## 3544   1883  Larry 0.000107  boy    L600
    ## 4099   1884  Leroy 0.001255  boy    L600
    ## 4441   1884  Larry 0.000147  boy    L600
    ## 4922   1884 Lawyer 0.000049  boy    L600
    ## 5090   1885  Leroy 0.001397  boy    L600
    ## 5419   1885  Larry 0.000164  boy    L600
    ## 6100   1886  Leroy 0.001302  boy    L600
    ## 6363   1886  Larry 0.000193  boy    L600
    ## 6562   1886 Lawyer 0.000101  boy    L600
    ## 6911   1886 Laurie 0.000050  boy    L600
    ## 7088   1887  Leroy 0.001619  boy    L600
    ## 7415   1887  Larry 0.000156  boy    L600
    ## 7718   1887   Lora 0.000073  boy    L600
    ## 7878   1887  Laura 0.000055  boy    L600
    ## 7879   1887 Lawyer 0.000055  boy    L600
    ## 8095   1888  Leroy 0.001478  boy    L600
    ## 8435   1888  Larry 0.000146  boy    L600
    ## 8628   1888  Laura 0.000085  boy    L600
    ## 8995   1888 Leeroy 0.000046  boy    L600
    ## 9092   1889  Leroy 0.001562  boy    L600
    ## 9537   1889  Larry 0.000109  boy    L600
    ## 10074  1890  Leroy 0.001972  boy    L600
    ## 10366  1890  Larry 0.000200  boy    L600
    ## 10707  1890  Laura 0.000075  boy    L600
    ## 10951  1890 Lawyer 0.000050  boy    L600
    ## 11084  1891  Leroy 0.001739  boy    L600
    ## 11424  1891  Larry 0.000165  boy    L600
    ## 11811  1891 Lawyer 0.000064  boy    L600
    ## 11911  1891  Laura 0.000055  boy    L600
    ## 12087  1892  Leroy 0.001772  boy    L600
    ## 12454  1892  Larry 0.000145  boy    L600
    ## 12777  1892   Lora 0.000068  boy    L600
    ## 13076  1893  Leroy 0.002016  boy    L600
    ## 13387  1893  Larry 0.000182  boy    L600
    ## 13739  1893 Laurie 0.000074  boy    L600
    ## 13877  1893  Laura 0.000058  boy    L600
    ## 13878  1893 Leeroy 0.000058  boy    L600
    ## 14083  1894  Leroy 0.001913  boy    L600
    ## 14293  1894  Larry 0.000288  boy    L600
    ## 15078  1895  Leroy 0.001966  boy    L600
    ## 15299  1895  Larry 0.000292  boy    L600
    ## 16072  1896  Leroy 0.002154  boy    L600
    ## 16303  1896  Larry 0.000294  boy    L600
    ## 17066  1897  Leroy 0.002386  boy    L600
    ## 17325  1897  Larry 0.000271  boy    L600
    ## 17895  1897  Laura 0.000057  boy    L600
    ## 18068  1898  Leroy 0.002384  boy    L600
    ## 18300  1898  Larry 0.000295  boy    L600
    ## 18592  1898  Laura 0.000106  boy    L600
    ## 19069  1899  Leroy 0.002335  boy    L600
    ## 19302  1899  Larry 0.000295  boy    L600
    ## 20065  1900  Leroy 0.002588  boy    L600
    ## 20255  1900  Larry 0.000394  boy    L600
    ## 20821  1900 Laurie 0.000068  boy    L600
    ## 20823  1900 Leeroy 0.000068  boy    L600
    ## 21072  1901  Leroy 0.002318  boy    L600
    ## 21301  1901  Larry 0.000303  boy    L600
    ## 22062  1902  Leroy 0.002787  boy    L600
    ## 22277  1902  Larry 0.000347  boy    L600
    ## 23064  1903  Leroy 0.002629  boy    L600
    ## 23246  1903  Larry 0.000441  boy    L600
    ## 23759  1903 Leeroy 0.000077  boy    L600
    ## 24060  1904  Leroy 0.002895  boy    L600
    ## 24224  1904  Larry 0.000505  boy    L600
    ## 25055  1905  Leroy 0.003079  boy    L600
    ## 25230  1905  Larry 0.000503  boy    L600
    ## 25772  1905 Lawyer 0.000077  boy    L600
    ## 25969  1905  Laura 0.000056  boy    L600
    ## 25972  1905 Leeroy 0.000056  boy    L600
    ## 26062  1906  Leroy 0.002915  boy    L600
    ## 26229  1906  Larry 0.000500  boy    L600
    ## 26829  1906 Leeroy 0.000069  boy    L600
    ## 27050  1907  Leroy 0.003468  boy    L600
    ## 27265  1907  Larry 0.000397  boy    L600
    ## 27909  1907 Leeroy 0.000063  boy    L600
    ## 28056  1908  Leroy 0.003144  boy    L600
    ## 28254  1908  Larry 0.000421  boy    L600
    ## 28921  1908 Lawyer 0.000060  boy    L600
    ## 29055  1909  Leroy 0.003206  boy    L600
    ## 29237  1909  Larry 0.000492  boy    L600
    ## 29739  1909 Lawyer 0.000085  boy    L600
    ## 30050  1910  Leroy 0.003516  boy    L600
    ## 30217  1910  Larry 0.000552  boy    L600
    ## 30906  1910 Lawyer 0.000062  boy    L600
    ## 31059  1911  Leroy 0.002926  boy    L600
    ## 31272  1911  Larry 0.000381  boy    L600
    ## 31699  1911 Lawyer 0.000087  boy    L600
    ## 32066  1912  Leroy 0.002893  boy    L600
    ## 32278  1912  Larry 0.000363  boy    L600
    ## 32925  1912 Leeroy 0.000053  boy    L600
    ## 32956  1912  Larue 0.000051  boy    L600
    ## 33063  1913  Leroy 0.002953  boy    L600
    ## 33262  1913  Larry 0.000394  boy    L600
    ## 34060  1914  Leroy 0.002928  boy    L600
    ## 34268  1914  Larry 0.000389  boy    L600
    ## 34944  1914 Leeroy 0.000051  boy    L600
    ## 35066  1915  Leroy 0.002783  boy    L600
    ## 35287  1915  Larry 0.000343  boy    L600
    ## 36063  1916  Leroy 0.002923  boy    L600
    ## 36297  1916  Larry 0.000327  boy    L600
    ## 36967  1916 Leeroy 0.000048  boy    L600
    ## 37060  1917  Leroy 0.003075  boy    L600
    ## 37290  1917  Larry 0.000337  boy    L600
    ## 37905  1917 Leeroy 0.000052  boy    L600
    ## 38057  1918  Leroy 0.003260  boy    L600
    ## 38266  1918  Larry 0.000378  boy    L600
    ## 38787  1918 Leeroy 0.000066  boy    L600
    ## 39054  1919  Leroy 0.003373  boy    L600
    ## 39264  1919  Larry 0.000403  boy    L600
    ## 39725  1919 Leeroy 0.000076  boy    L600
    ## 40056  1920  Leroy 0.003228  boy    L600
    ## 40261  1920  Larry 0.000399  boy    L600
    ## 40741  1920 Leeroy 0.000071  boy    L600
    ## 41055  1921  Leroy 0.003294  boy    L600
    ## 41256  1921  Larry 0.000432  boy    L600
    ## 41694  1921 Leeroy 0.000077  boy    L600
    ## 42055  1922  Leroy 0.003263  boy    L600
    ## 42254  1922  Larry 0.000435  boy    L600
    ## 42706  1922 Leeroy 0.000076  boy    L600
    ## 43055  1923  Leroy 0.003260  boy    L600
    ## 43245  1923  Larry 0.000457  boy    L600
    ## 43731  1923 Leeroy 0.000071  boy    L600
    ## 44053  1924  Leroy 0.003351  boy    L600
    ## 44237  1924  Larry 0.000495  boy    L600
    ## 44783  1924 Leeroy 0.000063  boy    L600
    ## 45052  1925  Leroy 0.003373  boy    L600
    ## 45191  1925  Larry 0.000630  boy    L600
    ## 45774  1925 Leeroy 0.000063  boy    L600
    ## 46051  1926  Leroy 0.003323  boy    L600
    ## 46177  1926  Larry 0.000706  boy    L600
    ## 46710  1926 Leeroy 0.000071  boy    L600
    ## 47051  1927  Leroy 0.003368  boy    L600
    ## 47176  1927  Larry 0.000719  boy    L600
    ## 47652  1927 Leeroy 0.000082  boy    L600
    ## 48051  1928  Leroy 0.003395  boy    L600
    ## 48150  1928  Larry 0.000937  boy    L600
    ## 48669  1928 Leeroy 0.000078  boy    L600
    ## 49051  1929  Leroy 0.003450  boy    L600
    ## 49134  1929  Larry 0.001144  boy    L600
    ## 49692  1929 Leeroy 0.000072  boy    L600
    ## 50053  1930  Leroy 0.003373  boy    L600
    ## 50106  1930  Larry 0.001526  boy    L600
    ## 50702  1930 Leeroy 0.000070  boy    L600
    ## 51052  1931  Leroy 0.003404  boy    L600
    ## 51088  1931  Larry 0.002010  boy    L600
    ## 51865  1931 Leeroy 0.000051  boy    L600
    ## 52053  1932  Leroy 0.003426  boy    L600
    ## 52065  1932  Larry 0.002625  boy    L600
    ## 52689  1932 Leeroy 0.000075  boy    L600
    ## 53056  1933  Leroy 0.003286  boy    L600
    ## 53058  1933  Larry 0.003189  boy    L600
    ## 53655  1933 Leeroy 0.000079  boy    L600
    ## 54043  1934  Larry 0.004212  boy    L600
    ## 54054  1934  Leroy 0.003554  boy    L600
    ## 54802  1934 Leeroy 0.000057  boy    L600
    ## 54963  1934 Laurie 0.000041  boy    L600
    ## 55033  1935  Larry 0.005594  boy    L600
    ## 55050  1935  Leroy 0.003671  boy    L600
    ## 55771  1935 Leeroy 0.000061  boy    L600
    ## 56025  1936  Larry 0.007157  boy    L600
    ## 56057  1936  Leroy 0.003420  boy    L600
    ## 56732  1936 Leeroy 0.000064  boy    L600
    ## 57016  1937  Larry 0.009444  boy    L600
    ## 57056  1937  Leroy 0.003253  boy    L600
    ## 57724  1937 Leeroy 0.000064  boy    L600
    ## 58016  1938  Larry 0.010905  boy    L600
    ## 58061  1938  Leroy 0.003073  boy    L600
    ## 58788  1938 Leeroy 0.000054  boy    L600
    ## 59014  1939  Larry 0.012824  boy    L600
    ## 59061  1939  Leroy 0.002989  boy    L600
    ## 59741  1939 Leeroy 0.000058  boy    L600
    ## 60013  1940  Larry 0.014507  boy    L600
    ## 60066  1940  Leroy 0.002794  boy    L600
    ## 60833  1940 Leeroy 0.000048  boy    L600
    ## 61011  1941  Larry 0.016048  boy    L600
    ## 61067  1941  Leroy 0.002805  boy    L600
    ## 61875  1941 Leeroy 0.000042  boy    L600
    ## 62012  1942  Larry 0.015686  boy    L600
    ## 62069  1942  Leroy 0.002639  boy    L600
    ## 62906  1942 Leeroy 0.000038  boy    L600
    ## 62941  1942   Lary 0.000036  boy    L600
    ## 63012  1943  Larry 0.015801  boy    L600
    ## 63074  1943  Leroy 0.002573  boy    L600
    ## 63911  1943 Leeroy 0.000037  boy    L600
    ## 64012  1944  Larry 0.015869  boy    L600
    ## 64078  1944  Leroy 0.002451  boy    L600
    ## 64822  1944 Leeroy 0.000043  boy    L600
    ## 65011  1945  Larry 0.016636  boy    L600
    ## 65083  1945  Leroy 0.002320  boy    L600
    ## 65767  1945 Leeroy 0.000047  boy    L600
    ## 66011  1946  Larry 0.017233  boy    L600
    ## 66090  1946  Leroy 0.002092  boy    L600
    ## 66831  1946   Lary 0.000038  boy    L600
    ## 66881  1946 Leeroy 0.000034  boy    L600
    ## 67010  1947  Larry 0.018806  boy    L600
    ## 67098  1947  Leroy 0.001798  boy    L600
    ## 67929  1947 Leeroy 0.000031  boy    L600
    ## 68011  1948  Larry 0.018764  boy    L600
    ## 68097  1948  Leroy 0.001817  boy    L600
    ## 69010  1949  Larry 0.017652  boy    L600
    ## 69101  1949  Leroy 0.001635  boy    L600
    ## 69928  1949   Lary 0.000031  boy    L600
    ## 70011  1950  Larry 0.017289  boy    L600
    ## 70102  1950  Leroy 0.001564  boy    L600
    ## 70924  1950   Lary 0.000031  boy    L600
    ## 70983  1950 Leeroy 0.000027  boy    L600
    ## 71011  1951  Larry 0.015972  boy    L600
    ## 71111  1951  Leroy 0.001415  boy    L600
    ## 72014  1952  Larry 0.014316  boy    L600
    ## 72116  1952  Leroy 0.001340  boy    L600
    ## 73018  1953  Larry 0.012577  boy    L600
    ## 73126  1953  Leroy 0.001287  boy    L600
    ## 74019  1954  Larry 0.011888  boy    L600
    ## 74125  1954  Leroy 0.001272  boy    L600
    ## 75019  1955  Larry 0.010926  boy    L600
    ## 75133  1955  Leroy 0.001158  boy    L600
    ## 76021  1956  Larry 0.010401  boy    L600
    ## 76140  1956  Leroy 0.001094  boy    L600
    ## 76975  1956   Lary 0.000028  boy    L600
    ## 77022  1957  Larry 0.010010  boy    L600
    ## 77148  1957  Leroy 0.001053  boy    L600
    ## 78022  1958  Larry 0.009318  boy    L600
    ## 78159  1958  Leroy 0.000967  boy    L600
    ## 78981  1958   Lary 0.000028  boy    L600
    ## 79025  1959  Larry 0.008499  boy    L600
    ## 79159  1959  Leroy 0.000931  boy    L600
    ## 80028  1960  Larry 0.007382  boy    L600
    ## 80172  1960  Leroy 0.000861  boy    L600
    ## 81030  1961  Larry 0.006763  boy    L600
    ## 81171  1961  Leroy 0.000847  boy    L600
    ## 82031  1962  Larry 0.006046  boy    L600
    ## 82179  1962  Leroy 0.000810  boy    L600
    ## 83036  1963  Larry 0.005653  boy    L600
    ## 83177  1963  Leroy 0.000793  boy    L600
    ## 83927  1963  Laura 0.000032  boy    L600
    ## 84036  1964  Larry 0.005268  boy    L600
    ## 84173  1964  Leroy 0.000783  boy    L600
    ## 85038  1965  Larry 0.004967  boy    L600
    ## 85173  1965  Leroy 0.000811  boy    L600
    ## 86038  1966  Larry 0.004792  boy    L600
    ## 86184  1966  Leroy 0.000744  boy    L600
    ## 87038  1967  Larry 0.004681  boy    L600
    ## 87189  1967  Leroy 0.000718  boy    L600
    ## 88038  1968  Larry 0.004635  boy    L600
    ## 88196  1968  Leroy 0.000676  boy    L600
    ## 88981  1968  Laura 0.000032  boy    L600
    ## 89040  1969  Larry 0.004532  boy    L600
    ## 89202  1969  Leroy 0.000673  boy    L600
    ## 90043  1970  Larry 0.004257  boy    L600
    ## 90214  1970  Leroy 0.000614  boy    L600
    ## 91044  1971  Larry 0.004274  boy    L600
    ## 91234  1971  Leroy 0.000557  boy    L600
    ## 92047  1972  Larry 0.003947  boy    L600
    ## 92233  1972  Leroy 0.000549  boy    L600
    ## 93050  1973  Larry 0.003767  boy    L600
    ## 93245  1973  Leroy 0.000499  boy    L600
    ## 94055  1974  Larry 0.003491  boy    L600
    ## 94253  1974  Leroy 0.000474  boy    L600
    ## 95056  1975  Larry 0.003276  boy    L600
    ## 95251  1975  Leroy 0.000494  boy    L600
    ## 96060  1976  Larry 0.002968  boy    L600
    ## 96259  1976  Leroy 0.000464  boy    L600
    ## 97062  1977  Larry 0.002832  boy    L600
    ## 97267  1977  Leroy 0.000431  boy    L600
    ## 98063  1978  Larry 0.002645  boy    L600
    ## 98274  1978  Leroy 0.000413  boy    L600
    ## 99069  1979  Larry 0.002454  boy    L600
    ## 99281  1979  Leroy 0.000408  boy    L600
    ## 100070 1980  Larry 0.002301  boy    L600
    ## 100293 1980  Leroy 0.000377  boy    L600
    ## 101074 1981  Larry 0.002122  boy    L600
    ## 101306 1981  Leroy 0.000333  boy    L600
    ## 102077 1982  Larry 0.001970  boy    L600
    ## 102298 1982  Leroy 0.000357  boy    L600
    ## 103085 1983  Larry 0.001819  boy    L600
    ## 103347 1983  Leroy 0.000281  boy    L600
    ## 104091 1984  Larry 0.001659  boy    L600
    ## 104348 1984  Leroy 0.000282  boy    L600
    ## 105097 1985  Larry 0.001532  boy    L600
    ## 105347 1985  Leroy 0.000280  boy    L600
    ## 106108 1986  Larry 0.001366  boy    L600
    ## 106349 1986  Leroy 0.000282  boy    L600
    ## 107114 1987  Larry 0.001285  boy    L600
    ## 107385 1987  Leroy 0.000256  boy    L600
    ## 108123 1988  Larry 0.001222  boy    L600
    ## 108404 1988  Leroy 0.000245  boy    L600
    ## 109131 1989  Larry 0.001118  boy    L600
    ## 109424 1989  Leroy 0.000233  boy    L600
    ## 110144 1990  Larry 0.001020  boy    L600
    ## 110440 1990  Leroy 0.000233  boy    L600
    ## 111157 1991  Larry 0.000979  boy    L600
    ## 111468 1991  Leroy 0.000212  boy    L600
    ## 112173 1992  Larry 0.000887  boy    L600
    ## 112493 1992  Leroy 0.000196  boy    L600
    ## 113183 1993  Larry 0.000862  boy    L600
    ## 113542 1993  Leroy 0.000173  boy    L600
    ## 114196 1994  Larry 0.000766  boy    L600
    ## 114562 1994  Leroy 0.000164  boy    L600
    ## 115210 1995  Larry 0.000699  boy    L600
    ## 115553 1995  Leroy 0.000168  boy    L600
    ## 116219 1996  Larry 0.000686  boy    L600
    ## 116596 1996  Leroy 0.000151  boy    L600
    ## 117243 1997  Larry 0.000621  boy    L600
    ## 117588 1997  Leroy 0.000153  boy    L600
    ## 118248 1998  Larry 0.000596  boy    L600
    ## 118644 1998  Leroy 0.000134  boy    L600
    ## 119250 1999  Larry 0.000615  boy    L600
    ## 119695 1999  Leroy 0.000119  boy    L600
    ## 120280 2000  Larry 0.000536  boy    L600
    ## 120715 2000  Leroy 0.000117  boy    L600
    ## 121290 2001  Larry 0.000498  boy    L600
    ## 121797 2001  Leroy 0.000102  boy    L600
    ## 122306 2002  Larry 0.000460  boy    L600
    ## 122810 2002  Leroy 0.000101  boy    L600
    ## 123315 2003  Larry 0.000452  boy    L600
    ## 123799 2003  Leroy 0.000103  boy    L600
    ## 124333 2004  Larry 0.000425  boy    L600
    ## 124817 2004  Leroy 0.000104  boy    L600
    ## 125359 2005  Larry 0.000389  boy    L600
    ## 125952 2005  Leroy 0.000086  boy    L600
    ## 126379 2006  Larry 0.000361  boy    L600
    ## 126940 2006  Leroy 0.000091  boy    L600
    ## 127332 2007  Larry 0.000434  boy    L600
    ## 127997 2007  Leroy 0.000088  boy    L600
    ## 128375 2008  Larry 0.000380  boy    L600
    ## 128917 2008  Leroy 0.000102  boy    L600
    ## 129017 1880  Laura 0.010368 girl    L600
    ## 129173 1880   Lora 0.000758 girl    L600
    ## 129212 1880   Lura 0.000543 girl    L600
    ## 129301 1880  Leora 0.000287 girl    L600
    ## 130019 1881  Laura 0.009731 girl    L600
    ## 130169 1881   Lora 0.000809 girl    L600
    ## 130232 1881   Lura 0.000465 girl    L600
    ## 130344 1881  Leora 0.000233 girl    L600
    ## 131017 1882  Laura 0.009948 girl    L600
    ## 131234 1882   Lora 0.000475 girl    L600
    ## 131255 1882   Lura 0.000406 girl    L600
    ## 131332 1882  Leora 0.000251 girl    L600
    ## 131976 1882 Laurie 0.000043 girl    L600
    ## 132019 1883  Laura 0.009853 girl    L600
    ## 132196 1883   Lora 0.000633 girl    L600
    ## 132224 1883   Lura 0.000541 girl    L600
    ## 132349 1883  Leora 0.000225 girl    L600
    ## 133021 1884  Laura 0.009056 girl    L600
    ## 133225 1884   Lura 0.000531 girl    L600
    ## 133228 1884   Lora 0.000523 girl    L600
    ## 133393 1884  Leora 0.000189 girl    L600
    ## 133818 1884 Laurie 0.000058 girl    L600
    ## 134021 1885  Laura 0.009334 girl    L600
    ## 134172 1885   Lora 0.000796 girl    L600
    ## 134202 1885   Lura 0.000620 girl    L600
    ## 134462 1885  Leora 0.000148 girl    L600
    ## 134882 1885   Lera 0.000049 girl    L600
    ## 135022 1886  Laura 0.008924 girl    L600
    ## 135191 1886   Lora 0.000709 girl    L600
    ## 135233 1886   Lura 0.000501 girl    L600
    ## 135374 1886  Leora 0.000215 girl    L600
    ## 135948 1886 Laurie 0.000046 girl    L600
    ## 136022 1887  Laura 0.008776 girl    L600
    ## 136220 1887   Lora 0.000579 girl    L600
    ## 136223 1887   Lura 0.000560 girl    L600
    ## 136399 1887  Leora 0.000193 girl    L600
    ## 136824 1887 Laurie 0.000058 girl    L600
    ## 137025 1888  Laura 0.008572 girl    L600
    ## 137224 1888   Lora 0.000565 girl    L600
    ## 137245 1888   Lura 0.000480 girl    L600
    ## 137383 1888  Leora 0.000211 girl    L600
    ## 137678 1888   Lera 0.000079 girl    L600
    ## 137996 1888 Laurie 0.000042 girl    L600
    ## 138025 1889  Laura 0.008281 girl    L600
    ## 138194 1889   Lora 0.000729 girl    L600
    ## 138233 1889   Lura 0.000528 girl    L600
    ## 138434 1889  Leora 0.000164 girl    L600
    ## 138629 1889   Lera 0.000090 girl    L600
    ## 138991 1889 Laurie 0.000042 girl    L600
    ## 139027 1890  Laura 0.008103 girl    L600
    ## 139213 1890   Lora 0.000645 girl    L600
    ## 139232 1890   Lura 0.000545 girl    L600
    ## 139359 1890  Leora 0.000253 girl    L600
    ## 140030 1891  Laura 0.007676 girl    L600
    ## 140201 1891   Lora 0.000687 girl    L600
    ## 140240 1891   Lura 0.000519 girl    L600
    ## 140437 1891  Leora 0.000173 girl    L600
    ## 140822 1891 Laurie 0.000061 girl    L600
    ## 141029 1892  Laura 0.007754 girl    L600
    ## 141218 1892   Lora 0.000622 girl    L600
    ## 141297 1892   Lura 0.000369 girl    L600
    ## 141388 1892  Leora 0.000209 girl    L600
    ## 141782 1892   Lera 0.000067 girl    L600
    ## 142031 1893  Laura 0.007472 girl    L600
    ## 142212 1893   Lora 0.000648 girl    L600
    ## 142265 1893   Lura 0.000457 girl    L600
    ## 142380 1893  Leora 0.000226 girl    L600
    ## 142935 1893   Lera 0.000049 girl    L600
    ## 143032 1894  Laura 0.007331 girl    L600
    ## 143198 1894   Lora 0.000750 girl    L600
    ## 143262 1894   Lura 0.000462 girl    L600
    ## 143353 1894  Leora 0.000263 girl    L600
    ## 143881 1894   Lera 0.000055 girl    L600
    ## 144036 1895  Laura 0.006645 girl    L600
    ## 144211 1895   Lora 0.000672 girl    L600
    ## 144300 1895   Lura 0.000376 girl    L600
    ## 144374 1895  Leora 0.000227 girl    L600
    ## 144959 1895 Laurie 0.000049 girl    L600
    ## 145037 1896  Laura 0.006607 girl    L600
    ## 145209 1896   Lora 0.000710 girl    L600
    ## 145301 1896   Lura 0.000373 girl    L600
    ## 145414 1896  Leora 0.000194 girl    L600
    ## 145859 1896   Lera 0.000060 girl    L600
    ## 145978 1896 Laurie 0.000048 girl    L600
    ## 146039 1897  Laura 0.006384 girl    L600
    ## 146212 1897   Lora 0.000681 girl    L600
    ## 146324 1897   Lura 0.000330 girl    L600
    ## 146373 1897  Leora 0.000246 girl    L600
    ## 146850 1897   Lera 0.000060 girl    L600
    ## 147038 1898  Laura 0.006449 girl    L600
    ## 147235 1898   Lora 0.000573 girl    L600
    ## 147332 1898   Lura 0.000328 girl    L600
    ## 147407 1898  Leora 0.000212 girl    L600
    ## 147802 1898   Lera 0.000066 girl    L600
    ## 147902 1898  Larue 0.000055 girl    L600
    ## 148043 1899  Laura 0.005948 girl    L600
    ## 148219 1899   Lora 0.000622 girl    L600
    ## 148332 1899   Lura 0.000331 girl    L600
    ## 148378 1899  Leora 0.000238 girl    L600
    ## 148744 1899   Lera 0.000077 girl    L600
    ## 149045 1900  Laura 0.005741 girl    L600
    ## 149245 1900   Lora 0.000554 girl    L600
    ## 149362 1900   Lura 0.000274 girl    L600
    ## 149395 1900  Leora 0.000223 girl    L600
    ## 149906 1900   Lera 0.000057 girl    L600
    ## 150044 1901  Laura 0.005514 girl    L600
    ## 150232 1901   Lora 0.000625 girl    L600
    ## 150339 1901   Lura 0.000323 girl    L600
    ## 150362 1901  Leora 0.000275 girl    L600
    ## 150943 1901   Lera 0.000051 girl    L600
    ## 151043 1902  Laura 0.005565 girl    L600
    ## 151233 1902   Lora 0.000592 girl    L600
    ## 151307 1902   Lura 0.000382 girl    L600
    ## 151380 1902  Leora 0.000246 girl    L600
    ## 151807 1902   Lera 0.000068 girl    L600
    ## 152043 1903  Laura 0.005406 girl    L600
    ## 152255 1903   Lora 0.000521 girl    L600
    ## 152337 1903   Lura 0.000313 girl    L600
    ## 152354 1903  Leora 0.000288 girl    L600
    ## 152620 1903   Lera 0.000104 girl    L600
    ## 152949 1903  Larue 0.000050 girl    L600
    ## 153047 1904  Laura 0.005157 girl    L600
    ## 153263 1904   Lora 0.000492 girl    L600
    ## 153337 1904   Lura 0.000318 girl    L600
    ## 153355 1904  Leora 0.000291 girl    L600
    ## 153820 1904   Lera 0.000068 girl    L600
    ## 154049 1905  Laura 0.005057 girl    L600
    ## 154231 1905   Lora 0.000597 girl    L600
    ## 154345 1905   Lura 0.000316 girl    L600
    ## 154429 1905  Leora 0.000200 girl    L600
    ## 154614 1905   Lera 0.000106 girl    L600
    ## 155052 1906  Laura 0.004678 girl    L600
    ## 155246 1906   Lora 0.000558 girl    L600
    ## 155357 1906  Leora 0.000281 girl    L600
    ## 155379 1906   Lura 0.000262 girl    L600
    ## 155751 1906   Lera 0.000077 girl    L600
    ## 155941 1906  Larue 0.000051 girl    L600
    ## 156051 1907  Laura 0.004804 girl    L600
    ## 156288 1907   Lora 0.000430 girl    L600
    ## 156381 1907   Lura 0.000258 girl    L600
    ## 156450 1907  Leora 0.000190 girl    L600
    ## 156967 1907  Larue 0.000047 girl    L600
    ## 157052 1908  Laura 0.004396 girl    L600
    ## 157274 1908   Lora 0.000471 girl    L600
    ## 157367 1908   Lura 0.000274 girl    L600
    ## 157405 1908  Leora 0.000229 girl    L600
    ## 157687 1908   Lera 0.000090 girl    L600
    ## 157898 1908  Larue 0.000056 girl    L600
    ## 157956 1908 Laurie 0.000051 girl    L600
    ## 158055 1909  Laura 0.004142 girl    L600
    ## 158274 1909   Lora 0.000473 girl    L600
    ## 158366 1909   Lura 0.000272 girl    L600
    ## 158369 1909  Leora 0.000269 girl    L600
    ## 158739 1909   Lera 0.000082 girl    L600
    ## 158948 1909  Larue 0.000052 girl    L600
    ## 159053 1910  Laura 0.004374 girl    L600
    ## 159295 1910   Lora 0.000413 girl    L600
    ## 159389 1910  Leora 0.000248 girl    L600
    ## 159404 1910   Lura 0.000227 girl    L600
    ## 159714 1910   Lera 0.000083 girl    L600
    ## 159853 1910  Loree 0.000062 girl    L600
    ## 159885 1910  Larue 0.000057 girl    L600
    ## 160057 1911  Laura 0.004050 girl    L600
    ## 160275 1911   Lora 0.000448 girl    L600
    ## 160365 1911  Leora 0.000274 girl    L600
    ## 160404 1911   Lura 0.000226 girl    L600
    ## 160795 1911   Lera 0.000068 girl    L600
    ## 161057 1912  Laura 0.004115 girl    L600
    ## 161292 1912   Lora 0.000418 girl    L600
    ## 161398 1912  Leora 0.000229 girl    L600
    ## 161433 1912   Lura 0.000201 girl    L600
    ## 161773 1912   Lera 0.000072 girl    L600
    ## 161880 1912  Larue 0.000056 girl    L600
    ## 162062 1913  Laura 0.003751 girl    L600
    ## 162301 1913   Lora 0.000385 girl    L600
    ## 162396 1913  Leora 0.000231 girl    L600
    ## 162518 1913   Lura 0.000148 girl    L600
    ## 162770 1913   Lera 0.000072 girl    L600
    ## 162935 1913  Larue 0.000050 girl    L600
    ## 163059 1914  Laura 0.003840 girl    L600
    ## 163320 1914   Lora 0.000339 girl    L600
    ## 163422 1914  Leora 0.000202 girl    L600
    ## 163438 1914   Lura 0.000196 girl    L600
    ## 163794 1914  Larue 0.000068 girl    L600
    ## 163834 1914   Lera 0.000063 girl    L600
    ## 164061 1915  Laura 0.003634 girl    L600
    ## 164324 1915   Lora 0.000332 girl    L600
    ## 164404 1915  Leora 0.000218 girl    L600
    ## 164462 1915   Lura 0.000174 girl    L600
    ## 164732 1915  Larue 0.000081 girl    L600
    ## 164985 1915   Lera 0.000045 girl    L600
    ## 165064 1916  Laura 0.003448 girl    L600
    ## 165317 1916   Lora 0.000338 girl    L600
    ## 165403 1916  Leora 0.000224 girl    L600
    ## 165469 1916   Lura 0.000170 girl    L600
    ## 165756 1916  Larue 0.000076 girl    L600
    ## 165879 1916   Lera 0.000055 girl    L600
    ## 166064 1917  Laura 0.003389 girl    L600
    ## 166307 1917   Lora 0.000354 girl    L600
    ## 166419 1917   Lura 0.000205 girl    L600
    ## 166425 1917  Leora 0.000202 girl    L600
    ## 166679 1917  Larue 0.000091 girl    L600
    ## 166853 1917   Lera 0.000058 girl    L600
    ## 167064 1918  Laura 0.003379 girl    L600
    ## 167319 1918   Lora 0.000334 girl    L600
    ## 167433 1918  Leora 0.000195 girl    L600
    ## 167476 1918   Lura 0.000166 girl    L600
    ## 167649 1918  Larue 0.000098 girl    L600
    ## 167907 1918   Lera 0.000052 girl    L600
    ## 168071 1919  Laura 0.003119 girl    L600
    ## 168352 1919   Lora 0.000284 girl    L600
    ## 168412 1919  Leora 0.000211 girl    L600
    ## 168478 1919   Lura 0.000166 girl    L600
    ## 168692 1919  Larue 0.000088 girl    L600
    ## 168896 1919   Lera 0.000053 girl    L600
    ## 169063 1920  Laura 0.003351 girl    L600
    ## 169340 1920   Lora 0.000300 girl    L600
    ## 169466 1920  Leora 0.000171 girl    L600
    ## 169510 1920   Lura 0.000150 girl    L600
    ## 169593 1920  Larue 0.000119 girl    L600
    ## 169869 1920   Lera 0.000056 girl    L600
    ## 170071 1921  Laura 0.003119 girl    L600
    ## 170343 1921   Lora 0.000284 girl    L600
    ## 170425 1921  Leora 0.000199 girl    L600
    ## 170521 1921   Lura 0.000145 girl    L600
    ## 170663 1921  Larue 0.000097 girl    L600
    ## 170863 1921   Lera 0.000057 girl    L600
    ## 171068 1922  Laura 0.003133 girl    L600
    ## 171354 1922   Lora 0.000273 girl    L600
    ## 171425 1922  Leora 0.000196 girl    L600
    ## 171501 1922   Lura 0.000155 girl    L600
    ## 171664 1922  Larue 0.000096 girl    L600
    ## 172072 1923  Laura 0.002964 girl    L600
    ## 172353 1923   Lora 0.000282 girl    L600
    ## 172470 1923  Leora 0.000172 girl    L600
    ## 172538 1923   Lura 0.000141 girl    L600
    ## 172662 1923  Larue 0.000101 girl    L600
    ## 172928 1923   Lera 0.000050 girl    L600
    ## 173072 1924  Laura 0.002953 girl    L600
    ## 173361 1924   Lora 0.000279 girl    L600
    ## 173440 1924  Leora 0.000194 girl    L600
    ## 173552 1924   Lura 0.000135 girl    L600
    ## 173751 1924  Larue 0.000076 girl    L600
    ## 174075 1925  Laura 0.002840 girl    L600
    ## 174365 1925   Lora 0.000275 girl    L600
    ## 174465 1925  Leora 0.000173 girl    L600
    ## 174551 1925   Lura 0.000135 girl    L600
    ## 174679 1925  Larue 0.000094 girl    L600
    ## 174992 1925   Lera 0.000045 girl    L600
    ## 175081 1926  Laura 0.002742 girl    L600
    ## 175407 1926   Lora 0.000228 girl    L600
    ## 175478 1926  Leora 0.000171 girl    L600
    ## 175599 1926   Lura 0.000114 girl    L600
    ## 175664 1926  Larue 0.000097 girl    L600
    ## 176082 1927  Laura 0.002697 girl    L600
    ## 176371 1927   Lora 0.000280 girl    L600
    ## 176480 1927  Leora 0.000171 girl    L600
    ## 176557 1927   Lura 0.000131 girl    L600
    ## 176616 1927  Larue 0.000108 girl    L600
    ## 177082 1928  Laura 0.002636 girl    L600
    ## 177388 1928   Lora 0.000247 girl    L600
    ## 177531 1928  Leora 0.000145 girl    L600
    ## 177614 1928  Larue 0.000110 girl    L600
    ## 177640 1928   Lura 0.000102 girl    L600
    ## 178090 1929  Laura 0.002537 girl    L600
    ## 178384 1929   Lora 0.000264 girl    L600
    ## 178517 1929  Leora 0.000149 girl    L600
    ## 178644 1929   Lura 0.000101 girl    L600
    ## 178761 1929  Larue 0.000073 girl    L600
    ## 179089 1930  Laura 0.002495 girl    L600
    ## 179381 1930   Lora 0.000276 girl    L600
    ## 179549 1930  Leora 0.000132 girl    L600
    ## 179618 1930   Lura 0.000107 girl    L600
    ## 179677 1930  Larue 0.000088 girl    L600
    ## 179901 1930 Laurie 0.000056 girl    L600
    ## 180089 1931  Laura 0.002418 girl    L600
    ## 180374 1931   Lora 0.000267 girl    L600
    ## 180534 1931  Leora 0.000140 girl    L600
    ## 180594 1931   Lura 0.000112 girl    L600
    ## 180657 1931  Larue 0.000092 girl    L600
    ## 181088 1932  Laura 0.002485 girl    L600
    ## 181386 1932   Lora 0.000261 girl    L600
    ## 181540 1932  Leora 0.000132 girl    L600
    ## 181616 1932   Lura 0.000105 girl    L600
    ## 181642 1932  Larue 0.000099 girl    L600
    ## 181982 1932 Laurie 0.000047 girl    L600
    ## 182091 1933  Laura 0.002425 girl    L600
    ## 182372 1933   Lora 0.000282 girl    L600
    ## 182554 1933  Leora 0.000126 girl    L600
    ## 182728 1933   Lura 0.000078 girl    L600
    ## 182809 1933  Larue 0.000065 girl    L600
    ## 183096 1934  Laura 0.002251 girl    L600
    ## 183420 1934   Lora 0.000226 girl    L600
    ## 183597 1934  Leora 0.000112 girl    L600
    ## 183679 1934   Lura 0.000090 girl    L600
    ## 183735 1934  Larue 0.000077 girl    L600
    ## 183801 1934 Laurie 0.000066 girl    L600
    ## 184101 1935  Laura 0.002170 girl    L600
    ## 184382 1935   Lora 0.000254 girl    L600
    ## 184596 1935  Leora 0.000110 girl    L600
    ## 184635 1935   Lura 0.000097 girl    L600
    ## 184701 1935  Larue 0.000085 girl    L600
    ## 184834 1935 Laurie 0.000063 girl    L600
    ## 185106 1936  Laura 0.002095 girl    L600
    ## 185389 1936   Lora 0.000248 girl    L600
    ## 185602 1936  Leora 0.000111 girl    L600
    ## 185744 1936  Larue 0.000075 girl    L600
    ## 185782 1936 Laurie 0.000070 girl    L600
    ## 185790 1936   Lura 0.000069 girl    L600
    ## 185984 1936  Larae 0.000045 girl    L600
    ## 186105 1937  Laura 0.002141 girl    L600
    ## 186393 1937   Lora 0.000246 girl    L600
    ## 186619 1937  Leora 0.000109 girl    L600
    ## 186751 1937 Laurie 0.000074 girl    L600
    ## 186759 1937   Lura 0.000074 girl    L600
    ## 186774 1937  Larue 0.000072 girl    L600
    ## 187108 1938  Laura 0.002143 girl    L600
    ## 187365 1938   Lora 0.000280 girl    L600
    ## 187626 1938  Leora 0.000105 girl    L600
    ## 187695 1938 Laurie 0.000087 girl    L600
    ## 187754 1938   Lura 0.000074 girl    L600
    ## 187778 1938  Larue 0.000071 girl    L600
    ## 188107 1939  Laura 0.002093 girl    L600
    ## 188399 1939   Lora 0.000249 girl    L600
    ## 188574 1939 Laurie 0.000122 girl    L600
    ## 188628 1939  Leora 0.000103 girl    L600
    ## 188801 1939  Larue 0.000065 girl    L600
    ## 188809 1939   Lura 0.000064 girl    L600
    ## 189107 1940  Laura 0.001992 girl    L600
    ## 189412 1940   Lora 0.000237 girl    L600
    ## 189597 1940 Laurie 0.000115 girl    L600
    ## 189719 1940  Leora 0.000080 girl    L600
    ## 189767 1940   Lura 0.000071 girl    L600
    ## 189838 1940  Larry 0.000062 girl    L600
    ## 189954 1940  Larue 0.000048 girl    L600
    ## 190115 1941  Laura 0.001826 girl    L600
    ## 190418 1941   Lora 0.000218 girl    L600
    ## 190521 1941 Laurie 0.000143 girl    L600
    ## 190755 1941  Leora 0.000072 girl    L600
    ## 190883 1941  Larue 0.000055 girl    L600
    ## 190920 1941   Lura 0.000051 girl    L600
    ## 190968 1941  Larry 0.000047 girl    L600
    ## 191115 1942  Laura 0.001733 girl    L600
    ## 191465 1942   Lora 0.000181 girl    L600
    ## 191485 1942 Laurie 0.000167 girl    L600
    ## 191722 1942  Leora 0.000077 girl    L600
    ## 191910 1942   Lura 0.000054 girl    L600
    ## 191978 1942  Larry 0.000047 girl    L600
    ## 192117 1943  Laura 0.001665 girl    L600
    ## 192447 1943   Lora 0.000194 girl    L600
    ## 192459 1943 Laurie 0.000180 girl    L600
    ## 192849 1943  Leora 0.000059 girl    L600
    ## 192938 1943  Larry 0.000049 girl    L600
    ## 192940 1943   Lura 0.000049 girl    L600
    ## 193000 1943  Larue 0.000044 girl    L600
    ## 193119 1944  Laura 0.001643 girl    L600
    ## 193369 1944 Laurie 0.000264 girl    L600
    ## 193443 1944   Lora 0.000194 girl    L600
    ## 193828 1944  Leora 0.000062 girl    L600
    ## 193846 1944  Larry 0.000059 girl    L600
    ## 194077 1945  Laura 0.002660 girl    L600
    ## 194286 1945 Laurie 0.000438 girl    L600
    ## 194421 1945   Lora 0.000212 girl    L600
    ## 194839 1945   Lura 0.000060 girl    L600
    ## 194911 1945  Leora 0.000051 girl    L600
    ## 194975 1945  Larry 0.000047 girl    L600
    ## 195074 1946  Laura 0.002784 girl    L600
    ## 195259 1946 Laurie 0.000479 girl    L600
    ## 195416 1946   Lora 0.000210 girl    L600
    ## 195839 1946   Lura 0.000060 girl    L600
    ## 195888 1946   Lori 0.000055 girl    L600
    ## 195914 1946  Larry 0.000052 girl    L600
    ## 195973 1946  Leora 0.000046 girl    L600
    ## 196074 1947  Laura 0.002780 girl    L600
    ## 196273 1947 Laurie 0.000433 girl    L600
    ## 196423 1947   Lora 0.000204 girl    L600
    ## 196856 1947   Lori 0.000058 girl    L600
    ## 196865 1947   Lura 0.000057 girl    L600
    ## 196946 1947  Leora 0.000048 girl    L600
    ## 196984 1947  Larry 0.000045 girl    L600
    ## 197073 1948  Laura 0.002809 girl    L600
    ## 197272 1948 Laurie 0.000461 girl    L600
    ## 197397 1948   Lora 0.000230 girl    L600
    ## 197724 1948   Lori 0.000078 girl    L600
    ## 197970 1948  Larry 0.000047 girl    L600
    ## 198066 1949  Laura 0.003062 girl    L600
    ## 198224 1949 Laurie 0.000628 girl    L600
    ## 198408 1949   Lora 0.000221 girl    L600
    ## 198621 1949   Lori 0.000101 girl    L600
    ## 198926 1949  Larry 0.000052 girl    L600
    ## 198934 1949 Lorrie 0.000052 girl    L600
    ## 198998 1949   Lura 0.000047 girl    L600
    ## 199063 1950  Laura 0.003257 girl    L600
    ## 199195 1950 Laurie 0.000790 girl    L600
    ## 199345 1950   Lora 0.000292 girl    L600
    ## 199615 1950   Lori 0.000106 girl    L600
    ## 199858 1950  Larry 0.000061 girl    L600
    ## 199872 1950 Lorrie 0.000059 girl    L600
    ## 199955 1950  Leora 0.000051 girl    L600
    ## 200060 1951  Laura 0.003503 girl    L600
    ## 200139 1951 Laurie 0.001277 girl    L600
    ## 200346 1951   Lori 0.000288 girl    L600
    ## 200386 1951   Lora 0.000241 girl    L600
    ## 200708 1951 Lorrie 0.000083 girl    L600
    ## 200860 1951  Lorie 0.000059 girl    L600
    ## 200916 1951  Larry 0.000054 girl    L600
    ## 201053 1952  Laura 0.003779 girl    L600
    ## 201115 1952 Laurie 0.001716 girl    L600
    ## 201251 1952   Lori 0.000514 girl    L600
    ## 201361 1952   Lora 0.000274 girl    L600
    ## 201539 1952 Lorrie 0.000132 girl    L600
    ## 201706 1952  Lorie 0.000084 girl    L600
    ## 201862 1952  Lauri 0.000060 girl    L600
    ## 201985 1952  Larry 0.000048 girl    L600
    ## 202051 1953  Laura 0.003955 girl    L600
    ## 202103 1953 Laurie 0.001913 girl    L600
    ## 202174 1953   Lori 0.000927 girl    L600
    ## 202374 1953   Lora 0.000268 girl    L600
    ## 202505 1953 Lorrie 0.000154 girl    L600
    ## 202595 1953  Lorie 0.000115 girl    L600
    ## 202753 1953  Lauri 0.000076 girl    L600
    ## 202901 1953  Lorri 0.000057 girl    L600
    ## 202991 1953  Larry 0.000049 girl    L600
    ## 203045 1954  Laura 0.004380 girl    L600
    ## 203098 1954 Laurie 0.002154 girl    L600
    ## 203121 1954   Lori 0.001730 girl    L600
    ## 203351 1954   Lora 0.000303 girl    L600
    ## 203463 1954 Lorrie 0.000183 girl    L600
    ## 203499 1954  Lorie 0.000158 girl    L600
    ## 203678 1954  Lauri 0.000095 girl    L600
    ## 203763 1954  Lorri 0.000075 girl    L600
    ## 204041 1955  Laura 0.004493 girl    L600
    ## 204089 1955   Lori 0.002481 girl    L600
    ## 204090 1955 Laurie 0.002469 girl    L600
    ## 204362 1955   Lora 0.000291 girl    L600
    ## 204442 1955 Lorrie 0.000207 girl    L600
    ## 204488 1955  Lorie 0.000173 girl    L600
    ## 204652 1955  Lauri 0.000103 girl    L600
    ## 204718 1955  Lorri 0.000087 girl    L600
    ## 204905 1955  Larry 0.000059 girl    L600
    ## 205034 1956  Laura 0.005134 girl    L600
    ## 205066 1956   Lori 0.003468 girl    L600
    ## 205076 1956 Laurie 0.003011 girl    L600
    ## 205334 1956   Lora 0.000334 girl    L600
    ## 205365 1956 Lorrie 0.000279 girl    L600
    ## 205442 1956  Lorie 0.000209 girl    L600
    ## 205521 1956  Lauri 0.000157 girl    L600
    ## 205586 1956  Lorri 0.000126 girl    L600
    ## 205998 1956  Larry 0.000051 girl    L600
    ## 206031 1957  Laura 0.005805 girl    L600
    ## 206045 1957   Lori 0.004273 girl    L600
    ## 206073 1957 Laurie 0.003123 girl    L600
    ## 206335 1957   Lora 0.000351 girl    L600
    ## 206366 1957 Lorrie 0.000293 girl    L600
    ## 206391 1957  Lorie 0.000258 girl    L600
    ## 206480 1957  Lauri 0.000186 girl    L600
    ## 206588 1957  Lorri 0.000129 girl    L600
    ## 207029 1958  Laura 0.006542 girl    L600
    ## 207030 1958   Lori 0.006312 girl    L600
    ## 207070 1958 Laurie 0.003259 girl    L600
    ## 207330 1958   Lora 0.000388 girl    L600
    ## 207346 1958 Lorrie 0.000349 girl    L600
    ## 207371 1958  Lorie 0.000292 girl    L600
    ## 207460 1958  Lauri 0.000209 girl    L600
    ## 207478 1958  Lorri 0.000190 girl    L600
    ## 208027 1959   Lori 0.007228 girl    L600
    ## 208030 1959  Laura 0.006989 girl    L600
    ## 208056 1959 Laurie 0.003624 girl    L600
    ## 208308 1959   Lora 0.000428 girl    L600
    ## 208322 1959 Lorrie 0.000406 girl    L600
    ## 208372 1959  Lorie 0.000318 girl    L600
    ## 208406 1959  Lauri 0.000259 girl    L600
    ## 208422 1959  Lorri 0.000244 girl    L600
    ## 209020 1960   Lori 0.008985 girl    L600
    ## 209024 1960  Laura 0.008204 girl    L600
    ## 209037 1960 Laurie 0.004877 girl    L600
    ## 209255 1960   Lora 0.000578 girl    L600
    ## 209280 1960 Lorrie 0.000506 girl    L600
    ## 209287 1960  Lorie 0.000488 girl    L600
    ## 209364 1960  Lauri 0.000339 girl    L600
    ## 209423 1960  Lorri 0.000254 girl    L600
    ## 210014 1961   Lori 0.010535 girl    L600
    ## 210021 1961  Laura 0.008620 girl    L600
    ## 210043 1961 Laurie 0.005026 girl    L600
    ## 210236 1961   Lora 0.000640 girl    L600
    ## 210253 1961  Lorie 0.000587 girl    L600
    ## 210282 1961 Lorrie 0.000509 girl    L600
    ## 210356 1961  Lauri 0.000346 girl    L600
    ## 210369 1961  Lorri 0.000325 girl    L600
    ## 210938 1961  Loria 0.000064 girl    L600
    ## 211011 1962   Lori 0.011050 girl    L600
    ## 211021 1962  Laura 0.008630 girl    L600
    ## 211042 1962 Laurie 0.005266 girl    L600
    ## 211237 1962   Lora 0.000664 girl    L600
    ## 211251 1962  Lorie 0.000621 girl    L600
    ## 211279 1962 Lorrie 0.000509 girl    L600
    ## 211362 1962  Lauri 0.000335 girl    L600
    ## 211414 1962  Lorri 0.000274 girl    L600
    ## 211990 1962  Loria 0.000058 girl    L600
    ## 212008 1963   Lori 0.012027 girl    L600
    ## 212016 1963  Laura 0.009313 girl    L600
    ## 212047 1963 Laurie 0.004664 girl    L600
    ## 212213 1963   Lora 0.000804 girl    L600
    ## 212241 1963  Lorie 0.000657 girl    L600
    ## 212286 1963 Lorrie 0.000513 girl    L600
    ## 212384 1963  Lauri 0.000317 girl    L600
    ## 212403 1963  Lorri 0.000284 girl    L600
    ## 213014 1964  Laura 0.009693 girl    L600
    ## 213015 1964   Lori 0.009517 girl    L600
    ## 213059 1964 Laurie 0.004006 girl    L600
    ## 213218 1964   Lora 0.000805 girl    L600
    ## 213270 1964  Lorie 0.000568 girl    L600
    ## 213318 1964 Lorrie 0.000442 girl    L600
    ## 213384 1964  Lauri 0.000321 girl    L600
    ## 213414 1964  Lorri 0.000282 girl    L600
    ## 214017 1965  Laura 0.008877 girl    L600
    ## 214019 1965   Lori 0.008592 girl    L600
    ## 214060 1965 Laurie 0.003576 girl    L600
    ## 214229 1965   Lora 0.000759 girl    L600
    ## 214269 1965  Lorie 0.000564 girl    L600
    ## 214325 1965 Lorrie 0.000415 girl    L600
    ## 214413 1965  Lauri 0.000278 girl    L600
    ## 214463 1965  Lorri 0.000233 girl    L600
    ## 215020 1966  Laura 0.008856 girl    L600
    ## 215021 1966   Lori 0.008361 girl    L600
    ## 215063 1966 Laurie 0.003227 girl    L600
    ## 215224 1966   Lora 0.000774 girl    L600
    ## 215273 1966  Lorie 0.000545 girl    L600
    ## 215339 1966 Lorrie 0.000393 girl    L600
    ## 215434 1966  Lauri 0.000268 girl    L600
    ## 215481 1966  Lorri 0.000215 girl    L600
    ## 215617 1966   Lara 0.000135 girl    L600
    ## 216015 1967  Laura 0.009215 girl    L600
    ## 216024 1967   Lori 0.007899 girl    L600
    ## 216072 1967 Laurie 0.002870 girl    L600
    ## 216216 1967   Lora 0.000807 girl    L600
    ## 216277 1967   Lara 0.000550 girl    L600
    ## 216285 1967  Lorie 0.000520 girl    L600
    ## 216376 1967 Lorrie 0.000340 girl    L600
    ## 216446 1967  Lauri 0.000262 girl    L600
    ## 216557 1967  Lorri 0.000167 girl    L600
    ## 217011 1968  Laura 0.010965 girl    L600
    ## 217022 1968   Lori 0.007682 girl    L600
    ## 217079 1968 Laurie 0.002538 girl    L600
    ## 217203 1968   Lora 0.000886 girl    L600
    ## 217227 1968   Lara 0.000758 girl    L600
    ## 217299 1968  Lorie 0.000507 girl    L600
    ## 217400 1968 Lorrie 0.000315 girl    L600
    ## 217509 1968  Lauri 0.000214 girl    L600
    ## 217557 1968  Lorri 0.000179 girl    L600
    ## 218010 1969  Laura 0.010170 girl    L600
    ## 218020 1969   Lori 0.007954 girl    L600
    ## 218079 1969 Laurie 0.002626 girl    L600
    ## 218212 1969   Lora 0.000836 girl    L600
    ## 218223 1969   Lara 0.000767 girl    L600
    ## 218291 1969  Lorie 0.000546 girl    L600
    ## 218361 1969 Lorrie 0.000363 girl    L600
    ## 218479 1969  Lauri 0.000231 girl    L600
    ## 218577 1969  Lorri 0.000167 girl    L600
    ## 219013 1970  Laura 0.009002 girl    L600
    ## 219023 1970   Lori 0.007342 girl    L600
    ## 219088 1970 Laurie 0.002396 girl    L600
    ## 219235 1970   Lara 0.000727 girl    L600
    ## 219256 1970   Lora 0.000657 girl    L600
    ## 219322 1970  Lorie 0.000454 girl    L600
    ## 219408 1970 Lorrie 0.000305 girl    L600
    ## 219503 1970  Lauri 0.000215 girl    L600
    ## 219693 1970  Lorri 0.000123 girl    L600
    ## 220016 1971  Laura 0.007917 girl    L600
    ## 220025 1971   Lori 0.006757 girl    L600
    ## 220096 1971 Laurie 0.002143 girl    L600
    ## 220269 1971   Lora 0.000609 girl    L600
    ## 220273 1971   Lara 0.000601 girl    L600
    ## 220329 1971  Lorie 0.000454 girl    L600
    ## 220427 1971 Lorrie 0.000279 girl    L600
    ## 220525 1971  Lauri 0.000200 girl    L600
    ## 220705 1971  Lorri 0.000124 girl    L600
    ## 221017 1972  Laura 0.007303 girl    L600
    ## 221028 1972   Lori 0.005855 girl    L600
    ## 221098 1972 Laurie 0.002002 girl    L600
    ## 221286 1972   Lora 0.000554 girl    L600
    ## 221297 1972   Lara 0.000515 girl    L600
    ## 221336 1972  Lorie 0.000423 girl    L600
    ## 221462 1972 Lorrie 0.000250 girl    L600
    ## 221582 1972  Lauri 0.000175 girl    L600
    ## 221926 1972  Lorri 0.000082 girl    L600
    ## 222019 1973  Laura 0.006653 girl    L600
    ## 222028 1973   Lori 0.005453 girl    L600
    ## 222106 1973 Laurie 0.001863 girl    L600
    ## 222317 1973   Lora 0.000466 girl    L600
    ## 222334 1973   Lara 0.000424 girl    L600
    ## 222335 1973  Lorie 0.000424 girl    L600
    ## 222501 1973 Lorrie 0.000221 girl    L600
    ## 222643 1973  Lauri 0.000150 girl    L600
    ## 222927 1973  Lorri 0.000086 girl    L600
    ## 223021 1974  Laura 0.006204 girl    L600
    ## 223030 1974   Lori 0.005085 girl    L600
    ## 223116 1974 Laurie 0.001632 girl    L600
    ## 223321 1974   Lora 0.000444 girl    L600
    ## 223359 1974   Lara 0.000383 girl    L600
    ## 223372 1974  Lorie 0.000369 girl    L600
    ## 223542 1974 Lorrie 0.000199 girl    L600
    ## 223768 1974  Lauri 0.000116 girl    L600
    ## 224020 1975  Laura 0.006611 girl    L600
    ## 224039 1975   Lori 0.004260 girl    L600
    ## 224124 1975 Laurie 0.001465 girl    L600
    ## 224335 1975   Lora 0.000427 girl    L600
    ## 224344 1975   Lara 0.000409 girl    L600
    ## 224414 1975  Lorie 0.000312 girl    L600
    ## 224578 1975 Lorrie 0.000183 girl    L600
    ## 224788 1975  Lauri 0.000114 girl    L600
    ## 225020 1976  Laura 0.007157 girl    L600
    ## 225047 1976   Lori 0.003722 girl    L600
    ## 225137 1976 Laurie 0.001298 girl    L600
    ## 225294 1976   Lara 0.000493 girl    L600
    ## 225337 1976   Lora 0.000417 girl    L600
    ## 225474 1976  Lorie 0.000248 girl    L600
    ## 225695 1976 Lorrie 0.000136 girl    L600
    ## 225945 1976  Lauri 0.000087 girl    L600
    ## 226020 1977  Laura 0.006883 girl    L600
    ## 226057 1977   Lori 0.003083 girl    L600
    ## 226155 1977 Laurie 0.001072 girl    L600
    ## 226342 1977   Lara 0.000401 girl    L600
    ## 226344 1977   Lora 0.000395 girl    L600
    ## 226541 1977  Lorie 0.000203 girl    L600
    ## 226829 1977 Lorrie 0.000110 girl    L600
    ## 227019 1978  Laura 0.006838 girl    L600
    ## 227060 1978   Lori 0.002822 girl    L600
    ## 227168 1978 Laurie 0.000984 girl    L600
    ## 227348 1978   Lora 0.000378 girl    L600
    ## 227377 1978   Lara 0.000341 girl    L600
    ## 227627 1978  Lorie 0.000163 girl    L600
    ## 228020 1979  Laura 0.006898 girl    L600
    ## 228069 1979   Lori 0.002573 girl    L600
    ## 228176 1979 Laurie 0.000917 girl    L600
    ## 228377 1979   Lora 0.000344 girl    L600
    ## 228421 1979   Lara 0.000290 girl    L600
    ## 228649 1979  Lorie 0.000156 girl    L600
    ## 228986 1979 Lorrie 0.000084 girl    L600
    ## 229021 1980  Laura 0.007257 girl    L600
    ## 229076 1980   Lori 0.002295 girl    L600
    ## 229195 1980 Laurie 0.000753 girl    L600
    ## 229394 1980   Lara 0.000324 girl    L600
    ## 229415 1980   Lora 0.000301 girl    L600
    ## 229730 1980  Lorie 0.000128 girl    L600
    ## 230021 1981  Laura 0.007435 girl    L600
    ## 230091 1981   Lori 0.001947 girl    L600
    ## 230214 1981 Laurie 0.000685 girl    L600
    ## 230388 1981   Lara 0.000326 girl    L600
    ## 230436 1981   Lora 0.000274 girl    L600
    ## 230840 1981  Lorie 0.000104 girl    L600
    ## 231022 1982  Laura 0.007339 girl    L600
    ## 231098 1982   Lori 0.001644 girl    L600
    ## 231220 1982 Laurie 0.000652 girl    L600
    ## 231370 1982   Lara 0.000346 girl    L600
    ## 231439 1982   Lora 0.000271 girl    L600
    ## 231817 1982  Lorie 0.000106 girl    L600
    ## 232023 1983  Laura 0.007376 girl    L600
    ## 232113 1983   Lori 0.001410 girl    L600
    ## 232247 1983 Laurie 0.000534 girl    L600
    ## 232424 1983   Lara 0.000285 girl    L600
    ## 232451 1983   Lora 0.000256 girl    L600
    ## 233019 1984  Laura 0.008217 girl    L600
    ## 233143 1984   Lori 0.001152 girl    L600
    ## 233292 1984 Laurie 0.000453 girl    L600
    ## 233422 1984   Lara 0.000281 girl    L600
    ## 233480 1984   Lora 0.000236 girl    L600
    ## 234014 1985  Laura 0.008669 girl    L600
    ## 234158 1985   Lori 0.000972 girl    L600
    ## 234311 1985 Laurie 0.000423 girl    L600
    ## 234449 1985   Lara 0.000263 girl    L600
    ## 234481 1985   Lora 0.000236 girl    L600
    ## 235020 1986  Laura 0.007683 girl    L600
    ## 235182 1986   Lori 0.000796 girl    L600
    ## 235392 1986 Laurie 0.000319 girl    L600
    ## 235411 1986   Lara 0.000291 girl    L600
    ## 235570 1986   Lora 0.000187 girl    L600
    ## 236022 1987  Laura 0.006953 girl    L600
    ## 236229 1987   Lori 0.000624 girl    L600
    ## 236414 1987   Lara 0.000287 girl    L600
    ## 236431 1987 Laurie 0.000277 girl    L600
    ## 236567 1987   Lora 0.000187 girl    L600
    ## 237023 1988  Laura 0.006303 girl    L600
    ## 237242 1988   Lori 0.000566 girl    L600
    ## 237418 1988   Lara 0.000291 girl    L600
    ## 237479 1988 Laurie 0.000248 girl    L600
    ## 237647 1988   Lora 0.000157 girl    L600
    ## 238025 1989  Laura 0.005894 girl    L600
    ## 238272 1989   Lori 0.000496 girl    L600
    ## 238492 1989   Lara 0.000241 girl    L600
    ## 238520 1989 Laurie 0.000225 girl    L600
    ## 238683 1989   Lora 0.000149 girl    L600
    ## 239029 1990  Laura 0.005311 girl    L600
    ## 239323 1990   Lori 0.000415 girl    L600
    ## 239538 1990   Lara 0.000215 girl    L600
    ## 239649 1990 Laurie 0.000168 girl    L600
    ## 239769 1990   Lora 0.000130 girl    L600
    ## 240035 1991  Laura 0.004744 girl    L600
    ## 240350 1991   Lori 0.000363 girl    L600
    ## 240595 1991   Lara 0.000186 girl    L600
    ## 240685 1991 Laurie 0.000154 girl    L600
    ## 240937 1991   Lora 0.000100 girl    L600
    ## 241038 1992  Laura 0.004144 girl    L600
    ## 241400 1992   Lori 0.000320 girl    L600
    ## 241642 1992   Lara 0.000175 girl    L600
    ## 241768 1992 Laurie 0.000135 girl    L600
    ## 241873 1992   Lora 0.000113 girl    L600
    ## 242043 1993  Laura 0.003677 girl    L600
    ## 242446 1993   Lori 0.000283 girl    L600
    ## 242756 1993   Lara 0.000139 girl    L600
    ## 242945 1993 Laurie 0.000102 girl    L600
    ## 243046 1994  Laura 0.003515 girl    L600
    ## 243475 1994   Lori 0.000269 girl    L600
    ## 243724 1994   Lara 0.000148 girl    L600
    ## 243962 1994 Laurie 0.000099 girl    L600
    ## 244056 1995  Laura 0.003122 girl    L600
    ## 244581 1995   Lori 0.000206 girl    L600
    ## 244774 1995   Lara 0.000135 girl    L600
    ## 245066 1996  Laura 0.002719 girl    L600
    ## 245650 1996   Lori 0.000180 girl    L600
    ## 245777 1996   Lara 0.000141 girl    L600
    ## 246066 1997  Laura 0.002539 girl    L600
    ## 246707 1997   Lori 0.000159 girl    L600
    ## 246847 1997   Lara 0.000127 girl    L600
    ## 247074 1998  Laura 0.002208 girl    L600
    ## 247718 1998   Lori 0.000159 girl    L600
    ## 247826 1998   Lara 0.000133 girl    L600
    ## 248081 1999  Laura 0.001989 girl    L600
    ## 248781 1999   Lori 0.000145 girl    L600
    ## 248787 1999   Lara 0.000143 girl    L600
    ## 249085 2000  Laura 0.001870 girl    L600
    ## 249848 2000   Lara 0.000131 girl    L600
    ## 249863 2000   Lori 0.000128 girl    L600
    ## 250086 2001  Laura 0.001793 girl    L600
    ## 250723 2001   Lara 0.000170 girl    L600
    ## 250955 2001   Lori 0.000117 girl    L600
    ## 251106 2002  Laura 0.001589 girl    L600
    ## 251633 2002   Lara 0.000204 girl    L600
    ## 252125 2003  Laura 0.001364 girl    L600
    ## 252732 2003   Lara 0.000174 girl    L600
    ## 253129 2004  Laura 0.001263 girl    L600
    ## 253735 2004   Lara 0.000178 girl    L600
    ## 254147 2005  Laura 0.001158 girl    L600
    ## 254810 2005   Lara 0.000158 girl    L600
    ## 255172 2006  Laura 0.000985 girl    L600
    ## 255836 2006   Lara 0.000154 girl    L600
    ## 256184 2007  Laura 0.000868 girl    L600
    ## 256934 2007   Lara 0.000136 girl    L600
    ## 257215 2008  Laura 0.000767 girl    L600
    ## 257931 2008   Lara 0.000141 girl    L600
