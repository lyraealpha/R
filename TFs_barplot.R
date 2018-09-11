
Sys.setlocale("LC_ALL","Chinese") 
setwd('C:/Users/vega/Documents/R_Draw_pics')
getwd()


tab<-read.csv(file.choose(),header = T,row.names = 1) # from your path, with read.csv()
groups <- c(row.names(tab))
Up_regulated<-tab$up
Down_regulated<-tab$down

par(mar=c(0.5, 5, 0.5, 1))
plot.new()
plot.window(xlim=c(-18, 50), ylim=c(-3, 57))
ticks <- seq(-20, 50, 5)
y <- 1:57
h <- 0.2
lines(rep(0, 2), c(0, 57), col="black")
#segments(-10, y, 25, y, lty="dotted")
rect(-Down_regulated, y-h, 0, y+h, col="steel blue")
rect(0, y-h, Up_regulated,y+h, col="red")
mtext(groups, at=y, adj=0, side=2, las=1,cex = 0.8,line =1 )
par(cex.axis=0.5, mex=0.5)
axis(1, at=ticks, labels=abs(ticks), pos=0)
tw <- 3*strwidth("Up")
rect(-5, -2.8, 0, -4, col="steel blue")
rect(0, -2.8, 5, -4, col="red")
text(0, -3.3, "Down regulated", pos=2,cex = 0.75)
text(0, -3.3, "Up regulated", pos=4,cex=0.75)
text(-5, 58.5, "T01_T02_T03_vs_T04_T05_T06 Differentially Expressed TFs", pos=4,cex=1)
box("inner", col="grey")

