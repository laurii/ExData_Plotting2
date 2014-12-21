########################################
## Exploratory data analysis
## Course Project 2
## task: 2
## Author: laurii
## Date: 21.12.2014

## TASK:
## Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to 
## make a plot answering this question.

## Downloading file if doens not exists 
if (!file.exists("summarySCC_PM25.rds")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile = "exdata%2Fdata%2FNEI_data.zip", 
                method = "curl")
  unzip(zipfile = "exdata%2Fdata%2FNEI_data.zip")
}

## Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Filtering data for Maryland 
BC <- NEI[NEI$fips == "24510",]

## Aggregating data
BCPD <- aggregate(BC[c("Emissions")], list(year = BC$year), sum)

## Define the graphics and plot the data
png('plot2.png', width=480, height=480)
plot(BCPD$year, BCPD$Emissions, type = "l", 
     main = "Total emissions Baltimore City pollution over years in the US",
     xlab = "Year", ylab = "Emissions")
dev.off()

