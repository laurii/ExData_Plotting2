########################################
## Exploratory data analysis
## Course Project 2
## task: 3
## Author: laurii
## Date: 21.12.2014

## TASK:
## Of the four types of sources indicated by the type (point, nonpoint, onroad, 
## nonroad) variable, which of these four sources have seen decreases in 
## emissions from 1999–2008 for Baltimore City? Which have seen increases in 
## emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
## answer this question.

library(ggplot2)

## Downloading file if doens not exists 
if (!file.exists("summarySCC_PM25.rds")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile = "exdata%2Fdata%2FNEI_data.zip", 
                method = "curl")
  unzip(zipfile = "exdata%2Fdata%2FNEI_data.zip")
}

## Reading data
NEI <- readRDS("summarySCC_PM25.rds")

##  Create Data 
BC <- subset(NEI, fips == "24510") 
BCPD <- aggregate(BC[c("Emissions")], list(type = BC$type, year = BC$year), sum)

##  Create Plot
png('plot3.png', width=480, height=480)
p <- ggplot(BCPD, aes(x=year, y=Emissions, colour=type)) +
  geom_point(alpha=.4) +
  geom_smooth(alpha=.3, size=2, method = "loess") +
  ggtitle("Total Emissions by type in Baltimore City")+
  labs(x = "Year", y = "Emissions")

print(p)

dev.off()


