windowsFonts(myFont = windowsFont("Times New Roman"))
normalized_counts_pearson<-read.csv(file.choose(),header=T,row.names = 1)
cormatrix<-data.matrix(normalized_counts_pearson)
cormelt<-melt(cormatrix)
cormelt

ggplot(data = cormelt,aes(x=Var2, y=Var1, fill=value))+geom_tile(color="white")+
  scale_fill_gradient2(low = "white", high = "steelblue", 
                       space = "Lab",name=expression(paste(R^2)))+
  labs(x = "",y="")+theme(axis.text.x = element_text(angle = 0, vjust = 1,size = 12, hjust = 0.5))+
  theme_minimal()+coord_fixed()+geom_text(aes(label=round(value,3)))+
  theme(plot.title = element_text(color="black", face= "bold",size = 10, hjust =0.42,vjust = 0))+
  labs(title = "Pearson correlation between samples")+
  theme(axis.text.x=element_text(family="myFont",size=9,color="black",angle = 35,hjust = 1),
        axis.text.y=element_text(family="myFont",size=9,color="black",angle = 0) )+
  theme(legend.text = element_text(colour = 'steelblue', size = 8, face = 'bold'))