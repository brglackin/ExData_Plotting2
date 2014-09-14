#############################DESCRIPTION##############################################

#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore 
#City?

######################################################################################

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI[NEI$fips=="24510",]
carIdx<-grep("motor vehicle",tolower(SCC$Short.Name),fixed = TRUE)
SCC<-SCC[carIdx,c("SCC","Short.Name")]
NEI<-merge(NEI, SCC, by="SCC")
byYear<-ddply(NEI,c("year"),function(row) sum(row$Emissions))

#Start PNG graphics
png(file="plot5.png",width=480,height=480)
plot(byYear, xlab="Year",ylab="PM2.5 Emissions",main="Plot of PM2.5 Emissions By Year for Cars in Baltimore")

#And we're done
dev.off()