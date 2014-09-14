#############################DESCRIPTION##############################################

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot 
#answering this question.

######################################################################################

library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI[NEI$fips=="24510",]
byYear<-ddply(NEI,c("year"),function(row) sum(row$Emissions))

#Start PNG graphics
png(file="plot2.png",width=480,height=480)
plot(byYear, xlab="Year",ylab="PM2.5 Emissions",main="Plot of PM2.5 Emissions By Year in Baltimore")

#And we're done
dev.off()