## begin with the extraction:
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

## Plot number 4

png(file="plot4.png",width=480,height=480) ## Set width height

## set 2x2 grip opf plots
par(mfrow = c(2, 2))

## plot 1
with (PW_C_short, plot(Global_active_power~newdate, type="l",## create the lines graphic
                       ylab="Global Active Power", ##title y axis
                       xlab="")) ## title x axis
## plot 2
with (PW_C_short, plot(Voltage~newdate, type="l",## create the lines graphic
                       xlab="datetime", ##title x axis
                       ylab="voltage")) ## title y axis

## plot 3
with (PW_C_short, plot(Sub_metering_1~newdate, type="l",xlab="",
                       ylab="Energy sub metering",ylim=c(0,ymax)))## lines plot
par(new="TRUE")         ## add next plot
with (PW_C_short, plot(Sub_metering_2~newdate, type="l",col="red",
                       xlab="", ylab="", axes=FALSE,ylim=c(0,ymax)))
par(new="TRUE")         ## add next plot
with (PW_C_short, plot(Sub_metering_3~newdate, type="l",col="blue",
                       xlab="", ylab="", axes=FALSE, ylim=c(0,ymax)))
legend("topright", lty=c(1,1,1),col=c("black", "red", "blue"),
       legend=c("sub_metering_1","sub_metering_2","sub_metering_3"))

## plot 4
with (PW_C_short, plot(Global_reactive_power~newdate, type="l",## create the lines graphic
                       xlab="datetime", ##title x axis
                       ylab="Global_reactive_power")) ## title y axis
dev.off() ## close the file