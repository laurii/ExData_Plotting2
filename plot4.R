########################################
## Exploratory data analysis
## Course Project 2
## task: 4
## Author: laurii
## Date: 21.12.2014

## TASK:
## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

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

## Create Data
CC <- unique(grep("coal",SCC$EI.Sector,value=T,ignore.case=T))
SCC_CC <- SCC[SCC$EI.Sector %in% CC,]
NEI.CC <- NEI[NEI$SCC %in% SCC_CC$SCC, ]

pd <- aggregate(NEI.CC[c("Emissions")], list(year = NEI.CC$year), sum)

##  Create Plot
png('plot4.png', width=480, height=480)
p <- ggplot(pd, aes(x=year, y=Emissions)) +
  geom_point(alpha=.4) +
  geom_smooth(alpha=.3, size=2, method="loess") +
  ggtitle("Total PM2.5 Coal Combustion Emissions in the US")+
  labs(x = "Year", y = "Emissions")
print(p)
dev.off()

