#' ---
#' title: "Lecture 12 for Hadley Wickham's STAT 405 at Rice   \t Groupwise Operation" 
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---
#'
#' ## Getting started
#+ message = FALSE, warning = FALSE
library(ggplot2)
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
kable(head(subset(bnames, soundex == "J500"), 10))

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

bnames <- ddply(bnames, c("sex", "year"), mutate,
                rank = rank(-prop, ties.method = "min"))
#' ddply + mutate = group-wise transformation
#' ddply + summarise = per-group summaries
#' ddply + subset = per-group subsets
kable(head(bnames))

#' ## Challenges
#' You now have all the tools to solve 95%
#' of data manipulation problems in R. It's
#' just a matter of figuring out which tools to
#' use, and how to combine them.
#' The following challenges will give you
#' some practice.

#' ### Warmups
#' Which names were most popular in 1999?
bnames %>% filter(year == 1999) %>% arrange(desc(prop)) %>% head() %>% kable

#' Or
# subset(bnames, year == 1999 & rank < 10)
n1999 <- subset(bnames, year == 1999)
head(arrange(n1999, desc(prop)), 10) %>% kable

#' Work out the average yearly usage of each name.
bnames %>% group_by(name) %>% summarize(ave_yearly = mean(prop)) %>% head() %>% kable

#' Or
# Average usage
overall <- ddply(bnames, "name", summarise,
                 prop1 = mean(prop),
                 prop2 = sum(prop) / 129)
kable(head(overall))

#' List the 10 names with the highest average proportions.
bnames %>% group_by(name) %>% summarize(ave_yearly = mean(prop)) %>% 
  arrange(desc(ave_yearly)) %>% 
  head(10) %>% kable

#' Or
head(arrange(overall, desc(prop1)), 10) %>% kable

#' ### Challenge 1  
#' How has the total proportion of babies
#' with names in the top 1000 changed over
#' time?

top_oneK <- bnames %>% group_by(year, sex) %>% summarize(prop = sum(prop))
qplot(year, prop, data = top_oneK, colour = sex,
      geom = "line")

#' Or 
sy <- ddply(bnames, c("year","sex"), summarise,
            prop = sum(prop),
            npop = sum(prop > 1/1000))
qplot(year, prop, data = sy, colour = sex,
      geom = "line")
# qplot(year, npop, data = sy, colour = sex,
#      geom = "line")  # does not work

#' How has the popularity of different initials
#' changed over time? 
first_init <- bnames2 %>% group_by(year, first) %>% summarise(prop = sum(prop))
qplot(year, prop, data = first_init, colour = first,
      geom = "line")

#' Or, Hadley's solution - different
init <- ddply(bnames2, c("year","first"), summarise,
              prop = sum(prop)/2) # divide by 2?
qplot(year, prop, data = init, colour = first,
      geom = "line")

#' ### Challenge 2  
#' For each name, find the year in which it
#' was most popular, and the rank in that
#' year. (Hint: you might find which.max useful).
bnames %>% group_by(name) %>% 
  summarize(peak_year = year[which.max(prop)], rank = min(rank)) %>%
  head() %>% kable

#' Or, Hadley's solution
most_pop <- ddply(bnames, "name", summarise,
                  year = year[which.max(prop)],
                  rank = min(rank))
most_pop <- ddply(bnames, "name", subset,
                  prop == max(prop))
most_pop %>% head() %>% kable

#' Print all names that have been the most
#' popular name at least once.
bnames %>% filter(rank == 1)

#' Or, Hadley's proposed solution
subset(most_pop, rank == 1)
# Double challenge: Why is this last one wrong?

#' ### Challenge 3
#' What name has been in the top 10 most often?
#' (Hint: you'll have to do this in three steps.
#'  Think about what they are before starting)
bnames %>% filter(rank <= 10) %>% group_by(name, sex) %>% count() %>% 
  arrange(desc(n)) %>% head(10) %>% kable

#' Or Hadley's solution
top10 <- subset(bnames, rank <= 10)
counts <- plyr::count(top10, c("sex", "name"))
ddply(counts, "sex", subset, freq == max(freq))
head(arrange(counts, desc(freq)), 10) %>% kable
