
Sys.setlocale("LC_ALL","Chinese") 
setwd('C:/Users/vega/Documents/pheatmap')
getwd()

require(pheatmap) 

sucrose<-read.csv(file.choose(),header=T,row.names=1)

sucrose<-log10(sucrose+1)

head(sucrose)

pheatmap(sucrose, color=colorRampPalette(rev(c("red","orange","white" )))(100),show_rownames=T,
         legend=T,cellwidth=60,cellheight=30,scale="none", cluster_rows = F,
         cluster_cols = F,fontsize_row = 10,main="",border_color="grey")

pheatmap(sucrose,cutree_rows = 3,cutree_cols = 2,
         color=colorRampPalette(rev(c("red","white","blue")))(100),show_rownames=F, 
             legend=T,cellwidth=36, scale="row", cluster_rows = T,border_color = "grey60",
             cluster_cols = T,fontsize_row = 5,main="Cluster analysis of DEGs")

pheatmap(sucrose,
         color=colorRampPalette(rev(c("red","white","blue")))(100),show_rownames=F, 
         legend=T,cellwidth=36, scale="row", cluster_rows = T,
         cluster_cols = T,fontsize_row = 5,main="Cluster analysis of DEGs")