#' ---
#' title: "R scripts can be rendered!"
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---
#' 
#' This is an exrperiment in rendering an R script to arkdown. We'll use the built-in 
#' dataset `VADeaths`.
## Regular code comment
summary(VADeaths)

#' More prose. I can use markdown syntax to make thingss **bold** or *italics*. Let's make
#' a Cleveland dot plot from the `VADeaths` data.
dotchart(VADeaths, main = "Death Rates in Virginia - 1940")

#' render with the following command
#' rmarkdown::render("renderMarkdown.R")