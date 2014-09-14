#############################DESCRIPTION##############################################

#Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city 
#has seen greater changes over time in motor vehicle emissions?

######################################################################################

library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI[NEI$type == 'ON-ROAD',]
NEI <- NEI[NEI$fips=="24510" | NEI$fips=="06037",]
byYearAndFips<-ddply(NEI,c("year","fips"),function(row) sum(row$Emissions))
colnames(byYearAndFips)<-c("year", "fips", "count")

#Start PNG graphics
png(file="plot6.png",width=480,height=480)
g<-ggplot(byYearAndFips, aes(x=year, y=count, color = fips)) 
g<-g + geom_line(aes(width=2.0)) + xlab("Year") + ylab("PM2.5 Emissions")
print(g)

#And we're done
dev.off()