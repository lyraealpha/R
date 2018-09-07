
Sys.setlocale("LC_ALL","Chinese") 
setwd('C:/Users/vega/Documents/bioconductor-all/DESeq2/Cm_Cs')
getwd()


source("http://bioconductor.org/biocLite.R")
biocLite('DESeq2')
biocLite('clusterProfiler')
biocLite('GenomeInfoDb')
biocLite('tibble')
biocLite('backports')
biocLite('org.Hs.eg.db')
biocLite('KEGG.db')
biocLite('DO.db')
biocLite('DOSE')
biocLite('KEGGREST')
biocLite('reactome.db')
install.packages('gplots')
install.packages('psych')

require('ggplot2')
require('DESeq2')
require('limma')
require('reshape2')
library("dplyr")
require('pheatmap')
require('RColorBrewer')
require('geneplotter')
library("AnnotationDbi")
require('clusterProfiler')
require('gplots')
require('org.Hs.eg.db')
library('KEGG.db')
library('DO.db')
library('DOSE')
require('psych')


fpkm<-read.csv(file.choose(),header = T,row.names = 1)
head(fpkm) 
fpkm<-log10(fpkm+1)
fpkm<-melt(fpkm)
colnames(fpkm)<-c("treatment","value")


windowsFonts(myFont = windowsFont("Times New Roman"))
ggplot(fpkm, aes(x = treatment, y = value))+ 
      geom_boxplot(aes(fill = treatment),alpha = 0.5,outlier.size = 1,width=0.5)+
      xlab("") + ylab(expression(paste(log[10],"(FPKM+1)",sep = ""),size=12))+
      labs(title = "FPKM distribution")+
      theme(panel.background = element_rect(fill = "transparent"))+
      theme(panel.border = element_rect(colour = "black",fill = "NA"))+
      theme(panel.grid.minor = element_blank())+
  theme(plot.title = element_text(color="black",size = 12, hjust =0.5,vjust = 0.5))+
  theme(axis.text.x=element_text(family="myFont",size=9,color="black",angle = 90,hjust = 1,vjust = 0.05))


windowsFonts(myFont = windowsFont("Times New Roman"))
ggplot(fpkm, aes(x = treatment, y = value))+ 
  geom_boxplot(aes(fill = treatment),alpha = 0.5,outlier.size = 1,width=0.5)+
  xlab("") + ylab(expression(paste(log[10],"(FPKM+1)",sep = ""),size=12))+
  labs(title = "FPKM distribution")+
  theme(panel.background = element_rect(fill = "transparent"))+
  theme(panel.border = element_rect(colour = "black",fill = "NA"))+
  theme(panel.grid.minor = element_blank())+
  theme(plot.title = element_text(color="black",size = 12, hjust =0.5,vjust = 0.5))+
  theme(axis.text.x=element_text(family="myFont",size=9,color="black",angle = 90,hjust = 1,vjust = 0.05))




