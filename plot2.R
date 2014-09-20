#############################DESCRIPTION##############################################

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot 
#answering this question.

######################################################################################

#We could do a barplot exaclty we did for the first plot, but just to change it up a bit
# we can do a line plot showing the trend of the emissions over time for Baltimore
# For this plot we do not need to change the scale of the Y axis
library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Only retain data for Baltimore
NEI <- NEI[NEI$fips=="24510",]
#Aggregate and sum the emissions by year
byYear<-ddply(NEI,c("year"),function(row) sum(row$Emissions))
colnames(byYear)<-c("year","count")

#Start PNG graphics
png(file="plot2.png",width=480,height=480)
plot(byYear, xlab="Year",ylab="PM2.5 Emissions",main="Plot of PM2.5 Emissions By Year in Baltimore",type="o",col="darkgreen",pch=19)

#And we're done
dev.off()