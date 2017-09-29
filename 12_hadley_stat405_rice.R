#' ---
#' title: "Lecture 12 for Hadley Wickham's STAT 405 at Rice   \t Groupwise Operation" 
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---
#'
#' ## Getting started
#+ message = FALSE, warning = FALSE
library(plyr)
library(stringr)
library(dplyr)
library(knitr)

options(stringsAsFactors = FALSE)
bnames <- read.csv("./data/bnames2.csv.bz2")
births <- read.csv("http://stat405.had.co.nz/data/births.csv")
kable(head(bnames))
kable(head(births))

#' ### Join files
bnames2 <- join(bnames, births, type = "left")
kable(head(bnames2))

#' ### Add `n` for counts, `first` for first letter of name, and `last` for last letter
bnames2 <- mutate(bnames2,
                  n = round(prop * births),
                  first = str_sub(name, 1, 1),
                  last = str_sub(name, -1, -1))
kable(head(bnames2))

#' ### Question
#' How do we compute the number of
#' people with each name over all years ?
#' It's pretty easy if you have a single name.
#' (e.g. how many people with your name
#' were born over the entire 128 years)
#'
#' #### Using `dplyr`
sum_by_name <- bnames2 %>% group_by(name, sex) %>% summarise(count = sum(n))
kable(head(sum_by_name))

#' #### Hadley's Solution  
#' Split
pieces <- split(bnames2, list(bnames$name))

#' Apply
results <- vector("list", length(pieces))
for(i in seq_along(pieces)) {
  piece <- pieces[[i]]
  results[[i]] <- summarise(piece,
                            name = name[1], n = sum(n))
}

#' Combine
result <- do.call("rbind", results)
kable(head(result))


#' Or equivalently
counts <- ddply(bnames2, "name", summarise,
                n = sum(n))
kable(head(counts))

#' ### Exercise
#' Repeat the same operation, but use
#' soundex instead of name. What is the
#' most common sound? What name does
#' it correspond to?
#'
#' #### Solution using `dplyr`
sound_by_name <- bnames2 %>% group_by(soundex) %>% summarise(count = sum(n)) %>%
  arrange(desc(count))
kable(head(sound_by_name))
kable(head(subset(bnames, soundex == "L500"), 10))

#' #### Hadley's solution
scounts <- ddply(bnames2, "soundex", summarise,
                 n = sum(n))
scounts <- arrange(scounts, desc(n))

# Combine with names
# When there are multiple possible matches,
# join picks the first

scounts <- join(
  scounts, bnames2[, c("soundex", "name")],
  by = "soundex")
kable(head(scounts, 10))
kable(head(subset(bnames, soundex == "L500"), 10))

#' Or equivalently
scounts <- ddply(bnames2, "soundex", summarise,
                 n = sum(n))

#' Specialised function for (weighted) counts
#' Faster, but only does one thing
scounts <- count(bnames2, "soundex", "n")

#' ### Transformations  
#' What about group-wise
#' transformations? e.g. what if we want to
#' compute the rank of a name within a sex
#' and year? (John was the nth most
#' popular boys name in 2008...)
#' This task is easy if we have a single year
#' & sex, but hard otherwise.  
#' 
#' For only one group
one <- subset(bnames, sex == "boy" & year == 2008)
one$rank <- rank(-one$prop,
                 ties.method = "first")
# or
one <- mutate(one,
              rank = rank(-prop, ties.method = "min"))
kable(head(one))

#' Using `dplyr`
boys_2008 <- bnames %>% filter(sex == "boy" & year == 2008) %>% 
  mutate(rank = min_rank(-prop))
kable(head(boys_2008))

#' #### What if we want to mutate every sex and year?
#' Workflow  
#' 1. Extract a single group
#' 2. Figure out how to solve it for just that group
#' 3. Use ddply to solve it for all groups
