volcano_csv<-read.csv(file.choose(),header = T,row.names = 1)
cols <- c("up regulated: 4879" = "red","FALSE" = "green","down regulated: 807" = "blue" )

ggplot(volcano_csv,aes(x = log2FoldChange,y = -log10(padj),color =sig2),legend=T)+
  geom_point(size=0.5)+
  scale_color_manual("Differential Expressed Genes(5686)",values = cols,
                     breaks = c("up regulated: 4879","down regulated: 807"),
                     limits = c("up regulated: 4879","down regulated: 807"))+
  scale_y_continuous(breaks=c(0,80,160,240,320),labels=c(0,80,160,240,320))+ 
  geom_hline(yintercept = -log10(0.01),linetype = "dashed",size = 0.4)+
  
  theme(title= element_text(size=10,  color="black", face= "bold", vjust=0.5, hjust=0.5))+
  xlab(expression(paste(log[2],"(Fold Change)",
                        sep = ""))) + ylab(expression(paste(-log[10],"(Padj)",sep = "")))+
  theme(panel.background = element_rect(fill = "transparent"),
        panel.border=element_rect(colour="black",fill=NA),
        panel.grid.minor = element_blank(), panel.grid.major = element_blank())+
  theme(legend.text= element_text(size=8,color="black", face= "bold", vjust=0.5, hjust=0.5))+
  labs(title = "Pumpkin_NaCl_vs_Pumpkin_control")+
  theme(plot.title = element_text(color="black", face= "bold",size = 12, hjust =0.42,vjust = 0))