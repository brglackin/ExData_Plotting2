#############################DESCRIPTION##############################################

#Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city 
#has seen greater changes over time in motor vehicle emissions?

######################################################################################

library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#For this analaysis we're only interested in on road emissions in Baltimore and LA
NEI <- NEI[NEI$type == 'ON-ROAD',]
NEI <- NEI[NEI$fips=="24510" | NEI$fips=="06037",]
#Aggeregate by year and location, getting total emissions
byYearAndFips<-ddply(NEI,c("year","fips"),function(row) sum(row$Emissions))
#For display purposes, we can set proper labels rather than using fips data
byYearAndFips[byYearAndFips$fips=='06037',]$fips<-"Los Angeles"
byYearAndFips[byYearAndFips$fips=='24510',]$fips<-"Baltimore"
colnames(byYearAndFips)<-c("year", "city", "count")

#Scale the emissions to be the log value so there's less extreme difference bewteen them
byYearAndFips$count<-log(byYearAndFips$count)

#Start PNG graphics
#For this graph, we're going to remove the ggplot background
png(file="plot6.png")
g<-ggplot(byYearAndFips, aes(x=year, y=count, color = city)) 
g<-g + geom_line(aes(width=3.0)) + xlab("Year") + ylab("log PM2.5 Emissions")
g<-g + ggtitle('    Motor Vehicle Emissions of PM2.5 in Baltimore and Los Angeles') 
g<-g + theme_bw()
print(g)

#And we're done
dev.off()
