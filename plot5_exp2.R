## To use this script you have to copy the uncompressed file household_power_consumption.txt with data in the working directory

## move to a proper working directory
## uncomment the next line and insert the correct path to the R script 
## setwd("<path to the working directory>")
setwd("/home/bompiani/Dropbox/Exploratory Data Analisys/ExData_Proj2/")

## load data in memory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## analysis
### levels(as.factor(SCC$EI.Sector)) to lok at the possible levels

## load library to get summarized values
library(plyr)

## Subset SCC data selecting EI Sector related  to Vehicles
SCC_VEHICLES <- subset(SCC, EI.Sector %in% c("Mobile - Non-Road Equipment - Diesel" , "Mobile - Non-Road Equipment - Gasoline", "Mobile - Non-Road Equipment - Other","Mobile - On-Road Diesel Heavy Duty Vehicles", "Mobile - On-Road Diesel Light Duty Vehicles", "Mobile - On-Road Gasoline Heavy Duty Vehicles","Mobile - On-Road Gasoline Light Duty Vehicles"))

## Merge SCC and NEI data
merged_data <- merge(NEI, SCC_VEHICLES , by = "SCC")

## Remove variables to free space
remove(NEI, SCC, SCC_VEHICLES)

## Calculate total values for each year
tot_emissions <-  ddply(merged_data, .(year), summarize, totEmissions = sum(Emissions) )

## Remove variables to free space
remove(merged_data)

library(ggplot2)
## Generate Plot
g <- ggplot(data = tot_emissions, aes(year,totEmissions))+geom_point()+geom_smooth(method="lm", se=FALSE)+labs(x="Year")+labs(y="Total Emissions [ tons ]")+labs(title=expression("Total "* PM[2.5]* " Emissions from Vehicles"))
print(g)

## Save the plot to disk
png(filename = "plot5.png",width = 480, height = 480)
print(g)
dev.off()