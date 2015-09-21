## To use this script you have to copy the uncompressed file household_power_consumption.txt with data in the working directory

## move to a proper working directory
## uncomment the next line and insert the correct path to the R script 
## setwd("<path to the working directory>")
setwd("/home/bompiani/Dropbox/Exploratory Data Analisys/ExData_Proj2/")

## load data in memory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## load library to get summarized values
library(plyr)

## Calculate total values for each year
tot_emissions <-  ddply(NEI, .(year), summarize, totEmissions = sum(Emissions)/ 10^6 )

## Generate Plot
with(tot_emissions,plot(tot_emissions$year,tot_emissions$totEmissions, pch = 19, col=2, xlab = "Year", ylab = "Total Emissions [ M tons ]", ))
title( "Total PM2.5 Emissions" )

model <- lm(totEmissions ~ year, tot_emissions)
abline(model, lwd = 2)

## Save the plot to disk
png(filename = "plot1.png",width = 480, height = 480)
with(tot_emissions,plot(tot_emissions$year,tot_emissions$totEmissions, pch = 19, col=2, xlab = "Year", ylab = "Total Emissions [ M tons ]", ))
title( "Total PM2.5 Emissions" )

model <- lm(totEmissions ~ year, tot_emissions)
abline(model, lwd = 2)
dev.off()
