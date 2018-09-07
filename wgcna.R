source("http://bioconductor.org/biocLite.R")
biocLite('WGCNA')
require('DESeq2')
require('ggplot2')
require('WGCNA')

Raw_count<-read.csv(file.choose(),header = T,row.names = 1)

condition <- factor(c('treatment1','treatment2'....))

dds <- DESeqDataSetFromMatrix(Raw_count, DataFrame(condition), ~ condition)

dds<-dds[rowSums(counts(dds))>1, ]

At_deseq2_dds<-DESeq(dds)
rld <- rlog(At_deseq2_dds)
plotPCA(rld)

Raw_count<-read.csv(file.choose(),header = T,row.names = 1)
head(Raw_count) 

dds <- DESeqDataSetFromMatrix(Raw_count, DataFrame(condition), ~ condition)

At_range<-read.csv(file.choose(),header = T,row.names = 1)#Grange
At_range_list<-makeGRangesFromDataFrame(At_range)
rowRanges(dds) <- At_range_list
At_deseq2_dds<-DESeq(dds)
fpkm(dds)
head(fpkm(dds))
write.csv(fpkm(dds),'PATH:At_FPKM.csv')

At_fpkm = read.csv(file.choose(),header=T,row.names = 1); 
(stringsAsFactors = FALSE)

dim(At_fpkm)
names(At_fpkm)
At_fpkm[1:4,1:4]

m.vars=apply(At_fpkm, 1,var)
At_fpkm.upper=At_fpkm[which(m.vars>quantile(m.vars, probs = seq( 0, 1, 0.25))[ 4]),]

dim(At_fpkm.upper) 

At_fpkm_filtered= as.data.frame(t(At_fpkm.upper));

gsg = goodSamplesGenes(At_fpkm_filtered, verbose = 3);
gsg$allOK
sampleTree = hclust(dist(At_fpkm_filtered), method = "average")
plot(sampleTree, main = "Sample clustering to detect outliers", sub= "", xlab= "")
nGenes = ncol(At_fpkm_filtered)
nSamples = nrow(At_fpkm_filtered)
save(At_fpkm_filtered, file = "FPKM-01-dataInput.RData") 


#»•¿Î»∫ (optional)
clust = cutreeStatic(sampleTree, cutHeight = 20000, minSize = 10)table(clust)
keepSamples = (clust== 1)
datExpr = datExpr[keepSamples, ]
nGenes = ncol(At_fpkm_filtered)
nSamples = nrow(At_fpkm_filtered)
save(At_fpkm_filtered, file = "FPKM-01-dataInput.RData") 

powers = c(c( 1: 10), seq( from= 12, to= 20, by= 2))
sft = pickSoftThreshold(At_fpkm_filtered, powerVector = powers, verbose = 5)

sizeGrWindow(9,5)
par(mfrow = c( 1, 2));
cex1 = 0.9;

plot(sft$fitIndices[, 1], -sign(sft$fitIndices[, 3])*sft$fitIndices[, 2], 
     xlab= "Soft Threshold (power)",ylab= "Scale Free Topology Model Fit,signed R^2",
     type= "n", main = paste( "Scale independence"));

text(sft$fitIndices[, 1], -sign(sft$fitIndices[, 3])*sft$fitIndices[, 2], labels=powers,cex=cex1,col= "red");

abline(h= 0.90,col= "red")

plot(sft$fitIndices[, 1], sft$fitIndices[, 5],
                               xlab= "Soft Threshold (power)",ylab= "Mean Connectivity", type= "n",
                               main = paste( "Mean connectivity"))

text(sft$fitIndices[, 1], sft$fitIndices[, 5],labels=powers, cex=cex1,col= "red") 

pow_selected=6

net = blockwiseModules(At_fpkm_filtered, power = pow_selected, maxBlockSize = 6000, 
                       TOMType = "unsigned", minModuleSize = 30, reassignThreshold = 0, 
                       mergeCutHeight = 0.25, numericLabels = TRUE, pamRespectsDendro = FALSE, 
                       saveTOMs = TRUE, saveTOMFileBase = "AS-green-FPKM-TOM", verbose = 3)
table(net$colors) 

MEs = net$MEs


mergedColors = labels2colors(net$colors) 
table(mergedColors)


plotDendroAndColors(net$dendrograms[[ 1]], mergedColors[net$blockGenes[[ 1]]], "Module colors",
                    dendroLabels = FALSE, hang = 0.03, addGuide = TRUE, guideHang = 0.05) 

TOM = TOMsimilarityFromExpr(At_fpkm_filtered, power = 6); 



# extract
module = "blue";
At_genes = colnames(At_fpkm_filtered) 
inModule = (mergedColors==module);
AT_blue = At_genes[inModule];
write.csv(AT_blue,'C:/Users/vega/Documents/WGCNA/WGCNA_blue.csv')
#clusterprofiler 

x=read.table("WGCNA_blue.txt")
genes_for_clusterprofiler=as.vector( x[,1] )

keeg_enri<-enrichKEGG(gene = genes_for_clusterprofiler,organism = "ath",pvalueCutoff = 0.05)

write.csv(as.data.frame(keeg_enri),"KEGG_enrich_blue.csv",row.names=F)

