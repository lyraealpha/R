Sys.setlocale("LC_ALL","Chinese")
setwd('C:/Users/vega/Documents/DRC')
getwd()

install.packages('DRC')

library(ggplot2)
require(drc)
require(car)
require(gtools)
require(multcomp)
require(scales)
require(plotrix)

growth<- read.csv(file.choose(),header=T,row.names=1)

treatment_labels<-c('A','B','C','D')
growth.m1 <- drm(growth~Concentration, CURVE, data = growth, fct = LL.4())
summary(growth.m1)
windowsFonts(myFont = windowsFont("Times New Roman"))
plot(growth.m1,broken=TRUE,main = "",
     xlab = expression(Concentration~(¦ÌM)),ylab = expression(Growth~Impact~Index),cex=1.05,lwd=1.5,
    legend = F,axes = F,lty=c(1,2,3,4),pch = c(19,15,17,18),xlim = c(10,180))
legend("topleft", legend =treatment_labels ,
       ncol =2.2365,cex = 1.0, lwd = 1.5,xjust = 0.5,lty=c(1,2,3,4),pch = c(19,15,17,18))
axis(side = 1,tck=0.01,las=0,at = c(0,10,20,40,60,80,120,160),cex.axis=0.9, 
     labels = paste(c(0,10,20,40,60,80,120,160),"", sep =""))
axis(side = 2,tck=0.01,las=2,at = c(-0.06,-0.03,0,0.03,0.06,0.09),cex.axis=1, 
     labels = paste(c(-0.06,-0.03,0,0.03,0.06,0.09),"", sep =""))