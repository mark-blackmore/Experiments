#' ---
#' title: "Lecture 14 for Hadley Wickham's STAT 405 at Rice \n Regular Expressions" 
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---
#'
library(stringr)
library(knitr)

#' ## Recap
#' Examine the structure of emails and basic string processing
contents <- readRDS("./data/email.rds")
breaks <- str_locate(contents, "\n\n")
headers <- str_sub(contents, end = breaks[, 1] - 1)
bodies <- str_sub(contents, start = breaks[, 2] + 1)


parse_headers <- function(x) {
  lines <- str_split(x, "\n")[[1]]
  continued <- str_sub(lines, 1, 1) %in% c(" ", "\t")
  # This is a useful trick!
  groups <- cumsum(!continued)
  fields <- rep(NA, max(groups))
  for (i in seq_along(fields)) {
    fields[i] <- str_c(lines[groups == i],
                       collapse = "\n")
  }
  fields
}

#' Now we want to apply that function to every
#' element of headers  
#' What should our output data structure look like?
#' It can't be a character vector. Why not?

n <- length(headers)

#' Instead, we need to use a list.
#' A list can contain any other data structure
#' (including other lists).
output <- vector("list", n)
for (i in seq_len(n)) {
  output[[i]] <- parse_headers(headers[i])
}

str(output)
output[1]
output[[1]]

#' If list x is a train carrying
#' objects, then x[[5]] is the
#' object in car 5; x[4:6] is a
#' train of cars 4-6

str(strsplit(headers[1], "\n"))
str(strsplit(headers[1], "\n")[1])
str(strsplit(headers[1], "\n")[[1]])
str(strsplit(headers, "\n"))

#' ## Exercise
#' Write a small function that given a single header
#' field splits it into name and contents. Do you
#' want to use str_split(), or str_locate() &
#'  str_sub()?  
#' Remember to get the algorithm working before
#' you write the function
test1 <- "Sender: <Lighthouse@independent.org>"
test2 <- "Subject: Alice: Where is my coffee?"

f1 <- function(input) {
  str_split(input, ": ")[[1]]
}
f2 <- function(input) {
  colon <- str_locate(input, ": ")
  c(
    str_sub(input, end = colon[, 1] - 1),
    str_sub(input, start = colon[, 2] + 1)
  )
}
f3 <- function(input) {
  str_split_fixed(input, ": ", 2)[1, ]
}
f1(test1)
f2(test1)
f2(test1)

#' ## Next Steps
#' We split the content into header and
#' body. And split up the header into fields.
#' Both of these tasks used fixed strings.
#' What if the pattern we need to match is
#' more complicated? 


