## begin with the extraction:
PW_C<-read.table("household_power_consumption.txt",header=TRUE, sep=";", 
                 na.strings="?",quote="")
PW_C$Date<-as.Date(PW_C$Date,"%d/%m/%Y") ##this is to convert to time class

## extract only the dates of interest
Date1<-as.Date("2007-02-01")
Date2<-as.Date("2007-02-02")
PW_C_short<- filter(PW_C, Date>=Date1 & Date<=Date2)
## Histogram plot

png(file="plot1.png",width=480,height=480) ## Set width height
## hago el grafico
with (PW_C_short, hist(Global_active_power,axes=TRUE, col="red",  ## Set color Red
                       xlab="Global Active Power (kilowatts)",  ## print axis label
                       cex.lab=1.1, cex.axis=0.9, mai=c(1,1,1,0), ## Set text height with cex      
                       main= "Global Active Power", cex.main=1, ## Print the title
                       font.axis=1)) ## height of title font
dev.off() ## close the file
