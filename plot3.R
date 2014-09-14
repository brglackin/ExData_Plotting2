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
colnames(byYearAndType)<-c("year", "type", "count")

#Start PNG graphics
png(file="plot3.png",width=480,height=480)
g<-ggplot(data=byYearAndType, aes(x=year, y=count)) + facet_grid(. ~ type) + guides(fill=F) +
  geom_bar(aes(fill=type),stat="identity") +
  ylab('PM2.5 Emissions') + xlab('Year') + 
  ggtitle('Emissions By Type in Baltimore') + geom_jitter(alpha=0.10)
print(g)
#And we're done
dev.off()