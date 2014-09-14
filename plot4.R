#############################DESCRIPTION##############################################

#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999-2008?

######################################################################################

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coalIdx<-grep("coal",tolower(SCC$Short.Name),fixed = TRUE)
SCC<-SCC[coalIdx,c("SCC","Short.Name")]
NEI<-merge(NEI, SCC, by="SCC")
byYear<-ddply(NEI,c("year"),function(row) sum(row$Emissions))

#Start PNG graphics
png(file="plot4.png",width=480,height=480)
plot(byYear, xlab="Year",ylab="PM2.5 Emissions",main="Plot of PM2.5 Emissions By Year for Coal")

#And we're done
dev.off()