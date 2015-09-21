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

## Subset Baltimore
NEI_Baltimore <- subset(NEI, fips==24510)
merged_data <- merge(NEI_Baltimore, SCC, by = "SCC")

## Remove variables to free space
remove(NEI, SCC)

## Calculate total values for each year, type
tot_emissions <-  ddply(merged_data, .(type,year), summarize, totEmissions = sum(Emissions) )

library(ggplot2)
## Generate Plot
g <- ggplot(data = tot_emissions, aes(year,totEmissions))+geom_point()+facet_wrap(~type, nrow = 2, ncol = 2 )+geom_smooth(method="lm", se=FALSE)+labs(x="Year")+labs(y="Total Emissions [ tons ]")+labs(title=expression("Total "* PM[2.5]* " Emissions in Baltimore"))
print(g)

## Save the plot to disk
png(filename = "plot3.png",width = 480, height = 480)
ggplot(data = tot_emissions, aes(year,totEmissions))+geom_point()+facet_wrap(~type, nrow = 2, ncol = 2 )+geom_smooth(method="lm", se=FALSE)+labs(x="Year")+labs(y="Total Emissions [ tons ]")+labs(title=expression("Total "* PM[2.5]* " Emissions in Baltimore"))
dev.off()