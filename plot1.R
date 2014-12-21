########################################
## Exploratory data analysis
## Course Project 2
## task: 1
## Author: laurii
## Date: 21.12.2014

## TASK:
## Have total emissions from PM2.5 decreased in the United States from 1999 to 
## 2008? Using the base plotting system, make a plot showing the total PM2.5 
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

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

## Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## To create the plot we need to aggregate the emissions
PD <- aggregate(NEI[c("Emissions")], list(year = NEI$year), sum)

## Define the graphics and plot the data
png('plot1.png', width=480, height=480)
plot(PD$year, PD$Emissions, type = "l", 
     main = "Total Emissions from PM2.5 in the US",
     xlab = "Year", ylab = "Emissions")
dev.off()



