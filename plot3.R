#############################DESCRIPTION##############################################

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions from 1999-2008 
#for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the 
#ggplot2 plotting system to make a plot answer this question.

######################################################################################

library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI[NEI$fips=="24510",]
byYearAndType<-ddply(NEI,c("year","type"),function(row) sum(row$Emissions))
#Start PNG graphics
png(file="plot3.png",width=480,height=480)
g<-ggplot(byYearAndType, aes(x=byYearAndType$year, y=byYearAndType$V1, color = byYearAndType$type)) 
g<-g + geom_point() + xlab("Year") + ylab("PM2.5 Emissions")
print(g)
#And we're done
dev.off()