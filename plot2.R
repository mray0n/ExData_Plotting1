## begin with the extraction:
## Assumig you have the unzip file in your WD

PW_C<-read.table("household_power_consumption.txt",header=TRUE, sep=";", 
                 na.strings="?",quote="")
PW_C$Date<-as.Date(PW_C$Date,"%d/%m/%Y") ##this is to convert to time class

## extract only the dates of interest
Date1<-as.Date("2007-02-01")
Date2<-as.Date("2007-02-02")
PW_C_short<- filter(PW_C, Date>=Date1 & Date<=Date2)


## We HAVE TO MERGE dATE AND TIME PARAMETERS TO GET A CONTINUOUS TIMESTAMP

PW_C_short$newdate <- with(PW_C_short, as.POSIXct ## LETS CREAte the newdate variable
                           (paste(Date, Time), format="%Y-%m-%d %H:%M"))

## set language to english, for x-time series

Sys.setlocale("LC_ALL", "English")

## create the plot

png(file="plot2.png",width=480,height=480) ## create the png file
with (PW_C_short, plot(Global_active_power~newdate, type="l",## create the lines graphic
                       ylab="Global Active Power (kilowatts)", ##title y axis
                       xlab="")) ## title x axis
dev.off() ## close the file
