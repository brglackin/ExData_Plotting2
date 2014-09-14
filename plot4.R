#############################DESCRIPTION##############################################

#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999-2008?

######################################################################################

library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coalIdx<-grep("coal",tolower(SCC$Short.Name),fixed = TRUE)
SCC<-SCC[coalIdx,c("SCC","Short.Name")]
NEI<-merge(NEI, SCC, by="SCC")
byYear<-ddply(NEI,c("year"),function(row) sum(row$Emissions))
colnames(byYear)<-c("year", "count")
byYear$count<-round(byYear$count/1000)

#Start PNG graphics
png(file="plot4.png",width=480,height=480)
g<-ggplot(data=byYear, aes(x=year, y=count)) + 
  geom_line() + geom_point(aes(size=2)) + 
  ggtitle('Total Emissions of PM2.5 from Coal Combustion') + 
  ylab('PM2.5 Emissions (in thousands)') + xlab('Year') + 
  geom_text(aes(label=round(count,digits=0), size=2, hjust=1.5, vjust=1.5))
print(g)

#And we're done
dev.off()
