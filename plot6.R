########################################
## Exploratory data analysis
## Course Project 2
## task: 6
## Author: laurii
## Date: 21.12.2014

## TASK
## Compare emissions from motor vehicle sources in Baltimore City with 
## emissions from motor vehicle sources in Los Angeles County, California 
## (fips == "06037"). Which city has seen greater changes over time in motor 
## vehicle emissions?

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


VEH <- unique(grep("vehicle",SCC$EI.Sector,value=T,ignore.case=T))
SCC.VEH <- SCC[SCC$EI.Sector %in% VEH,]

## Data for Baltimore City
BC <- subset(NEI, fips == "24510")
NEI.VEH.BC <- subset(BC, BC$SCC %in%  SCC.VEH$SCC)
BC.PD <- aggregate(NEI.VEH.BC[c("Emissions")], list(year = NEI.VEH.BC$year), sum)
BC.PD$city <- "Baltimore City"

## Data for Los Angeles County
LAC <- subset(NEI, fips == "06037")
NEI.VEH.LAC <- subset(LAC, LAC$SCC %in%  SCC.VEH$SCC)
LAC.PD <- aggregate(NEI.VEH.LAC[c("Emissions")], list(year = NEI.VEH.LAC$year), sum)
LAC.PD$city <- "Los Angeles City"

## binding two datasets
PD <- rbind(BC.PD,LAC.PD)

png('plot6.png', width=480, height=480)
p <- ggplot(PD, aes(x=year, y=Emissions, colour=city)) +
  geom_point(alpha=.3) +
  geom_smooth(alpha=.2, size=1, method="loess") +
  ggtitle("Vehicle Emissions in Baltimore vs. LA")

print(p)
dev.off()


