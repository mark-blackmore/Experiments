R scripts can be rendered!
================
Mark Blackmore
2017-09-26

Create a YAML (code above)

### Get Up to Date Packages

``` r
options(repos = c(CRAN = "https://cran.revolutionanalytics.com"))
```

### Check for data directory; Create one if not found

``` r
if (!file.exists("data")) {
  dir.create("data")
}
```

### Download data into Data Directory

``` r
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv")
list.files("./data")
```

    ##  [1] "cameras.csv"   "mpg2.csv.bz2"  "slots-2.csv"   "slots-3.csv"  
    ##  [5] "slots.csv"     "slots.csv.bz2" "slots.rds"     "slots.txt"    
    ##  [9] "tricky-1.csv"  "tricky-2.csv"  "tricky-3.csv"  "tricky-4.csv"

### Keep date downloaded

``` r
dateDownloaded <- date()
```
