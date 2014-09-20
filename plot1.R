#############################DESCRIPTION##############################################

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all 
#sources for each of the years 1999, 2002, 2005, and 2008.

######################################################################################

#We can show this as a barplot, with the year on the x axis and the emissions on
#the right axis. We will report emissions in millions to keep the y scale simpler

library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Aggregate and sum the emissions by year
byYear<-ddply(NEI,c("year"),function(row) sum(row$Emissions))
colnames(byYear)<-c("year","count")
#Scale the emissions to mmillions
byYear$count<-round(byYear$count/1000000)


#Start PNG graphics
png(file="plot1.png",width=480,height=480)
barplot(byYear$count, xlab="Year",ylab="PM2.5 Emissions (in millions)",main="Plot of PM2.5 Emissions By Year",col="darkgreen",
     names.arg=c("1999","2002","2005","2008"))

#And we're done
dev.off()