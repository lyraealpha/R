#pearson_and_Rsquare_from_2_files

fpkm1<-read.csv(file.choose(),header = T)
fpkm2<-read.csv(file.choose(),header = T)
matrix_a <-fpkm1
matrix_b <-fpkm2Re


r_square<-NULL
pvalue <- NULL
id<-(matrix_a[,1])
for (i in 1:nrow(matrix_a)){
  temp <- cor.test(as.numeric(matrix_a[i,]),as.numeric(matrix_b[i,]),method="pearson")
  pvalue[i] <- temp$p.value
  r_square[i]<-temp$estimate
}
Results <- data.frame(matrix_a[,1],r_square,pvalue)
write.csv(Results,'C:/Users/vega/Documents/bioconductor-all/test.csv')




