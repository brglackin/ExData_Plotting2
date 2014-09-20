#############################DESCRIPTION##############################################

#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore 
#City?

######################################################################################

library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#For this analysis we're only interested in Baltimore on road data
NEI <- NEI[NEI$fips=="24510" & NEI$type == 'ON-ROAD',]
#Aggregate and sum by year
byYear<-ddply(NEI,c("year"),function(row) sum(row$Emissions))
colnames(byYear)<-c("year", "count")

#Start PNG graphics
png(file="plot5.png",width=480,height=480)
g<-ggplot(data=byYear, aes(x=year, y=count)) + 
  geom_line() + geom_point(aes(size=2)) + 
  ggtitle('Total Emissions of PM2.5 from Motor Vehicles in Baltimore') + 
  ylab('PM2.5 Emissions (in thousands)') + xlab('Year') + 
  geom_text(aes(label=round(count,digits=0), size=2, hjust=1.5, vjust=1.5))
print(g)

#And we're done
dev.off()