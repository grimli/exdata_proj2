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

## Subset SCC data selecting EI Sector with Comb and Coal
SCC_COAL_COMB <- subset(subset(SCC, grepl(".*Comb.*", EI.Sector)), grepl(".*Coal.*", EI.Sector))

## Merge SCC and NEI data
merged_data <- merge(NEI, SCC_COAL_COMB, by = "SCC")

## Remove variables to free space
remove(NEI, SCC, SCC_COAL_COMB)

## Calculate total values for each year
tot_emissions <-  ddply(merged_data, .(year), summarize, totEmissions = sum(Emissions) )

library(ggplot2)
## Generate Plot
g <- ggplot(data = tot_emissions, aes(year,totEmissions))+geom_point()+geom_smooth(method="lm", se=FALSE)+labs(x="Year")+labs(y="Total Emissions [ tons ]")+labs(title=expression("Total "* PM[2.5]* " Emissions from Coal Combustion"))
print(g)

## Save the plot to disk
png(filename = "plot4.png",width = 480, height = 480)
print(g)
dev.off()