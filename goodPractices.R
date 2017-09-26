#' ---
#' title: "R scripts can be rendered!"
#' author: "Mark Blackmore"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---
#' Create a YAML (code above)
#'
#' ### Get Up to Date Packages
options(repos = c(CRAN = "https://cran.revolutionanalytics.com"))

#' ### Check for data directory; Create one if not found
if (!file.exists("data")) {
  dir.create("data")
}

#' ### Download data into Data Directory
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv")
list.files("./data")

#' ### Keep date downloaded
dateDownloaded <- date()