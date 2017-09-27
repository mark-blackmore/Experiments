#' ---
#' title: "Lecture 11 for Hadley Wickham's STAT 405 \t Advanced Data Manipulation" 
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---
#'
#' ## Baby names data
#' Top 1000 male and female baby
#' names in the US, from 1880 to 2008.  
#' 258,000 records (1000 * 2 * 129)
#' But only five variables: year,
#' name, soundex, sex and prop.
#' 
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
tail(bnames, 20)

#' ### Exercise: 
#' Extract your name from the dataset. Plot
#' the trend over time.
#' What geom should you use? Do you
#' need any extra aesthetics?

mark <- subset(bnames, name == "Mark")
qplot(year, prop, data = mark, color = sex, geom = "line")

sheryl <- subset(bnames, name == "Sheryl")
qplot(year, prop, data = sheryl, geom = "line")

garrett <- subset(bnames, name == "garrett")
hadley <- subset(bnames, name == "Hadley")
qplot(year, prop, data = garrett, geom = "line")
qplot(year, prop, data = hadley, color = sex,
      geom = "line")

#' ### Exercise:
#' Use the soundex variable to extract all
#' names that sound like yours. Plot the
#' trend over time. 
mark_soundex <- subset(bnames, soundex == "M620")
qplot(year, prop, data = mark_soundex, color = name, group = sex, geom = "line")

glike <- subset(bnames, soundex == "G630")
qplot(year, prop, data = glike)
qplot(year, prop, data = glike, geom = "line")
qplot(year, prop, data = glike, geom = "line",
      colour = sex)
qplot(year, prop, data = glike, geom = "line",
      colour = sex) + facet_wrap(~ name)
qplot(year, prop, data = glike, geom = "line",
      colour = sex, group = interaction(sex, name))

#' ### Exercise
#' In which year was your name most
#' popular? Least popular?
#' Reorder the data frame containing your
#' name from highest to lowest popularity.
#' Add a new column that gives the number
#' of babies per thousand with your name.

head(arrange(mark, desc(prop)),1)
head(arrange(mark, prop),1)     
head(mutate(mark, per1000 = prop*1000))

summarise(garrett,
          least = year[prop == min(prop)],
          most = year[prop == max(prop)])
# OR
summarise(garrett,
          least = year[which.min(prop)],
          most = year[which.max(prop)])
head(arrange(garrett, desc(prop)))
head(mutate(garrett, per1000 = round(1000 * prop)))

#' ## Merging Data
library(knitr)
what_played<- data.frame(name = c("John", "Paul",
  "George", "Ringo", "Stuart", "Pete"), instrument =
  c("guitar", "bass", "guitar", "drums", "bass", "drums"))

members <- data.frame(name = c("John", "Paul",
  "George", "Ringo", "Brian"), band = c("TRUE",
  "TRUE", "TRUE", "TRUE", "FALSE")) 

kable(join(what_played, members, type = "left"))
kable(join(what_played, members, type = "right"))
kable(join(what_played, members, type = "inner"))
kable(join(what_played, members, type = "full"))

#' ### Exercise
#' Convert from proportions to absolute
#' numbers by combining bnames with
#' births, and then performing the
#' appropriate calculation.

head(bnames)
head(births)
bnames2 <- join(bnames, births,
                by = c("year", "sex"))
tail(bnames2)

bnames2 <- mutate(bnames2, n = prop * births)
tail(bnames2)

bnames2 <- mutate(bnames2, n = round(prop * births))
tail(bnames2)

head(arrange(bnames2, desc(n)))

library(dplyr)
bnames2 %>% filter(name == "Mark") %>% arrange(desc(n)) %>% head()

#' Births database does not contain all births!
qplot(year, births, data = births, geom = "line",
      color = sex)

#' ### Add to Beatles data.  How could we combine what_player & members now?
members$instrument <- c("vocals", "vocals", "backup",
                        "backup", "manager")

kable(what_played)
kable(members)

kable(join(what_played, members, type = "full"))
# :(

kable(join(what_played, members, by = "name", type = "full"))
# :(

names(members)[3] <- "instrument2"
kable(members)
kable(join(what_played, members, type = "full"))

#' ## Groupwise Operations  
#' 
#' How do we compute the number of
#' people with each name over all years ?
#' It's pretty easy if you have a single name.
#' (e.g. how many people with your name
#'  were born over the entire 128 years)
garrett <- subset(bnames2, name == "garrett")
sum(garrett$n)
# Or
summarise(garrett, n = sum(n))
#' But how could we do this for every name?
