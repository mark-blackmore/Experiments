
# Get Up to Date Packages
options(repos = c(CRAN = "https://cran.revolutionanalytics.com"))

# Check for data directory; Create one if not found
if (!file.exists("data")) {
  dir.create("data")
}

# Download data into Data Directory
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
list.files("./data")

# Keep data downloaded
dateDownloaded <- date()