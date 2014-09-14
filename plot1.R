#############################DESCRIPTION##############################################

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all 
#sources for each of the years 1999, 2002, 2005, and 2008.

######################################################################################

library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

byYear<-ddply(NEI,c("year"),function(row) sum(row$Emissions))
colnames(byYear)<-c("year","count")
byYear$count<-round(byYear$count/1000000)
#Start PNG graphics
png(file="plot1.png",width=480,height=480)
plot(byYear, xlab="Year",ylab="PM2.5 Emissions (in millions)",main="Plot of PM2.5 Emissions By Year",type="o",col="red")

#And we're done
dev.off()