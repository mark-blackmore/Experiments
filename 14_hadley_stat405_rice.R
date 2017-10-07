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

#' ### Exercise
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

#' ### Next Steps  
#' We split the content into header and
#' body. And split up the header into fields.
#' Both of these tasks used fixed strings.
#' What if the pattern we need to match is
#' more complicated?   
#'  
#' ### Matching Challenges  
#' * How could we match a phone number?
#' * How could we match a date?
#' * How could we match a time?
#' * How could we match an amount of
#' money?
#' * How could we match an email address?
#' 
#' ## Regular Expressions  
#' Each of these types of data have a fairly
#' regular pattern that we can easily pick out by eye
#' Today we are going to learn about regular
#' expressions, which are an extremely
#' concise language for describing patterns.
#' 
#' #### First challenge  
#' * Matching phone numbers
#' * How are phone numbers normally written?
#' * How can we describe this format?
#' * How can we extract the phone numbers?
#' 
#' ##### Phone numbers
#' * 10 digits, normally grouped 3-3-4
#' * Separated by space, - or ()
#' * How can we express that with a computer
#' program? We'll use regular expressions
#'
#  [0-9]: matches any number between 0 and 9
#  [- ()]: matches -, space, ( or )
#' 
phone <- "[ (][0-9][0-9][0-9][- )][0-9][0-9][0-9][- ][0-9][0-9][0-9][0-9]"
phone2 <- "[0-9]{3}[- .][0-9]{3}[- .][0-9]{4}"
phone3 <- "[(][0-9]{3}[)][- .][0-9]{3}[- ()][0-9]{4}"
# test <- body[10]
# cat(test)
# 
# str_detect(test, phone2)
# str_locate(test, phone2)
# str_locate_all(test, phone2)
# 
# str_extract(test, phone2)
# str_extract_all(test, phone2)

#' What do these regular expression match?
mystery1 <- "[0-9]{5}(-[0-9]{4})?"
mystery2 <- "[0-9]{3}-[0-9]{2}-[0-9]{4}"
mystery3 <- "[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}"
mystery4 <- "https?://[a-z]+([a-z0-9-]*[a-z0-9]+)?(\\.([a-z]+([a-z0-9-]*[a-z0-9]+)?)+)*"
#' Think about them first, then input to http://strfriend.com/
#' or http://xenon.stanford.edu/~xusch/regexp/analyzer.html
#' (select java for language - it's closest to R for regexps)

