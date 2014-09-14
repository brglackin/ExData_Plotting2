#############################DESCRIPTION##############################################

#Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city 
#has seen greater changes over time in motor vehicle emissions?

######################################################################################

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI[NEI$fips=="24510" | NEI$fips=="06037",]
carIdx<-grep("motor vehicle",tolower(SCC$Short.Name),fixed = TRUE)
SCC<-SCC[carIdx,c("SCC","Short.Name")]
NEI<-merge(NEI, SCC, by="SCC")
byYearAndFips<-ddply(NEI,c("year","fips"),function(row) sum(row$Emissions))

#Start PNG graphics
png(file="plot6.png",width=480,height=480)
g<-ggplot(byYearAndFips, aes(x=byYearAndFips$year, y=byYearAndFips$V1, color = byYearAndFips$fips)) 
g<-g + geom_point() + xlab("Year") + ylab("PM2.5 Emissions")
print(g)

#And we're done
dev.off()