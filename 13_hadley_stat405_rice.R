#' ---
#' title: "Lecture 13 for Hadley Wickham's STAT 405 at Rice \n String Processing" 
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---
library(knitr)

#' ## String Processing
#' 1. Motivation: classify spam
#' 2. String basics
#' 3. stringr package
#' 
#' ### Emails  
#' Examine the structure of emails and basic string processing
file_URL <- "http://stat405.had.co.nz/data/email.rds"
contents <- readRDS(gzcon(url(file_URL)))
str(contents)
head(contents)
contents[1]
cat(contents[1], "\n")

#' #### Structure of an email
#' * Headers give metadata 
#' * Blank line 
#' * Body of email    
#' 
#' Other major complication is attachments
#' and alternative content, but we'll ignore
#' those for class
#' 
#' #### Tasks
#' * Split into header and contents
#' * Split header into fields
#' * Make variable that might be interesting to explore  
#' 
#' ### String Basics
#' Special characters
a <- "\""
b <- "\\"
c <- "a\nb\nc"
a # displays the representation
cat(a, "\n") # displays the actual string
b
cat(b, "\n") # "\n" tells R to start a new line
c
cat(c, "\n")

contents[1]
#' Does exactly the same thing
#' (unless you're inside a function)
print(contents[1])
cat(contents[1], "\n")

#' #### Special characters
#' * Use `\` to "escape" special characters
#' * `\"` = `"`
#' * `\n` = new line
#' * `\\` = `\`
#' * `\t` = tab
#' * ?Quotes for more
#' 
#' ### Exercise
#' Create a string for each of the following strings:
#' :-\
#' (^_^")
#' @_'-'
#' \m/
#' Create a multiline string.
#' Compare the output from print() and cat()

a <- ":-\\"
print(a) 
cat(a, "\n")

b <- "(^_^\")"
print(b)
cat(b, "\n")

c <- "@_'-'"
print(c)
cat(c, "\n")

d <- "\\m/"
print(d)
cat(d, "\n")

e <- "Create\na\nmultiline\nstring."
print(e)
cat(e, "\n")

#' ## Stringr
# install.packages("stringr")

#+ warning = FALSE
library(stringr)

#+ eval = FALSE 
help(package = "stringr")
#' The last call lists all functions in a package.  
#' All functions in stringr start with str_

#+ eval = TRUE
apropos("str_")
#' The last call lists all functions with names containing
#' specified characters 
#'
#' ### Header vs. Content
#' Need to split the string into two pieces,
#' based on the the location of double line
#' break:  
#' *   str_locate(string, pattern)  
#' Need two substrings, one to the right and
#' one to the left:  
#' *   str_sub(string, start, end)  
#'   
#' #### Examples
str_locate("great", "a") # "a" starts and ends at position shown
str_locate("fantastic", "a") # first instance
str_locate("super", "a")

superlatives <- c("great", "fantastic", "super")
res <- str_locate(superlatives, "a")
str(res) # matrix
res

str(str_locate_all(superlatives, "a")) # list
str_sub("testing", 1, 3)
str_sub("testing", start = 4) # by default goes to end
str_sub("testing", end = 4) # by default starts at 1

input <- c("abc", "defg")
str_sub(input, c(2, 3)) # item 1 - start at 2, item 2 - start at 3

#' ### Exercise
#' Use str_locate() to identify the location
#' of the blank line. (Hint: a blank line is a newline
#'                     immediately followed by another newline).  
#' Split the emails into header and content
#' with str_sub()
#' Make sure to check your results.
breaks <- str_locate(contents, "\n\n")
kable(head(breaks))

#' Extract headers and bodies
header <- str_sub(contents, end = breaks[, 1])
body <- str_sub(contents, start = breaks[, 2])

#' Is everything ok with breaks?

#' ### Headers
#' Each header starts at the beginning of a new line
#' Each header is composed of a name
#' and contents, separated by a colon 
h <- header[2]

#' Does this work?
str_split(h, "\n")[[1]]

#' Fix the issue
lines <- str_split(h, "\n")
#' because str_split returns a list with one element
#' for each input string
lines <- lines[[1]]
continued <- str_sub(lines, 1, 1) %in% c(" ", "\t")

#' This is a useful trick!
groups <- cumsum(!continued)
fields <- rep(NA, max(groups))
for (i in seq_along(fields)) {
  fields[i] <- str_c(lines[groups == i], collapse = "\n")
}
#' Or
tapply(lines, groups, str_c, collapse = "\n")

#' ### Exercise
#' Write a small function that given a single header
#' field splits it into name and contents. Do you
#' want to use str_split(), or str_locate() &
#'   str_sub()?
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

#' ### Next Steps
#' We split the content into header and
#' body. And split up the header into fields.
#' Both of these tasks used fixed strings.
#' What if the pattern we need to match is
#' more complicated?  
#' 
#' See next lecture.
