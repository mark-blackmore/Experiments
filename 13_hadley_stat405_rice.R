#' ---
#' title: "Lecture 13 for Hadley Wickham's STAT 405 at Rice \n String Processing" 
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---
#'
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
#' Headers give metadata
#' Blank line
#' Body of email
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