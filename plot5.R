########################################
## Exploratory data analysis
## Course Project 2
## task: 5
## Author: laurii
## Date: 21.12.2014

## TASK
## How have emissions from motor vehicle sources changed from 1999–2008 in 
## Baltimore City? 

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
SCC <- readRDS("Source_Classification_Code.rds")

##  Create Data
VEH <- unique(grep("vehicle",SCC$EI.Sector,value=T,ignore.case=T))
SCC.VEH <- SCC[SCC$EI.Sector %in% VEH,]
BC <- subset(NEI, fips == "24510")
NEI.VEH <- subset(BC, BC$SCC %in%  SCC.VEH$SCC)
pd <- aggregate(NEI.VEH[c("Emissions")], list(year = NEI.VEH$year), sum)

##  Create Plot
png('plot5.png', width=480, height=480)
p <- ggplot(pd, aes(x=year, y=Emissions))+
             geom_point(alpha=.4) +
             geom_smooth(alpha=.3, size=2, method="loess") +
             ggtitle("Total Vehicle Emissions in Baltimore City") +
             labs(x = "Year", y = "Emissions")
print(p)

dev.off()


