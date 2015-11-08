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

## to turn language into english:
Sys.setlocale("LC_ALL", "English")

## Obtengo el maximo de para el eje y:
ymax<-max(c(max(PW_C_short$Sub_metering_1),
            max(PW_C_short$Sub_metering_2),
            max(PW_C_short$Sub_metering_3)),na.rm=T)

png(file="plot3.png",width=480,height=480) ## creo el fichero
with (PW_C_short, plot(Sub_metering_1~newdate, type="l",xlab="",
                       ylab="Energy sub metering",ylim=c(0,ymax)))## grafico con lineas
par(new="TRUE")
with (PW_C_short, plot(Sub_metering_2~newdate, type="l",col="red",
                       xlab="", ylab="", axes=FALSE,ylim=c(0,ymax)))
par(new="TRUE")
with (PW_C_short, plot(Sub_metering_3~newdate, type="l",col="blue",
                       xlab="", ylab="", axes=FALSE, ylim=c(0,ymax)))
legend("topright", lty=c(1,1,1),col=c("black", "red", "blue"),
       legend=c("sub_metering_1","sub_metering_2","sub_metering_3"))
dev.off() ## close the file
