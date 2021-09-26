#!/usr/bin/env Rscript
library('optparse')
library('EnhancedVolcano')
library('export')

option_list = list(
                make_option(c('-i','--dmc_file'),type='character',
                                                      default=NULL,
                                                      help='DMC.txt file created by CHAMP',
                                                      metavar="dmc_file"),
                make_option(c('-s','--show_probs'),type='character',
                                                      default=NULL,
                                                      help='list of probes will be showdn in volcano plot',
                                                      metavar="show_probs"),
                make_option(c('-v','--versus_name'),type='character',
                                                      default=NULL,
                                                      help='versus_name of plot',
                                                      metavar="versus_name"),                                                                                                             
                make_option(c('-o','--oprefix'),type='character',
                                                 default=NULL,
                                                 help='output file prefix',
                                                 metavar="oprefix"),
                make_option(c('-m','--max_point'),type='numeric',
                                                 default='20',
                                                 help='max point to show on volcano plot',
                                                 metavar="oprefix"),                                                 
                make_option(c('-p','--pvalue'),type='numeric',
                                                 default='0.01',
                                                 help='pvalue cut off',
                                                 metavar="pvalue")                                                                                                    
               );
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

odir = dirname(normalizePath(opt$oprefix))
ifelse(!dir.exists(odir), dir.create(odir), "Folder odir exists already")

res <- read.table(opt$dmc_file, sep="\t", head=T, row.names=1, check.names=F, quote="", stringsAsFactors=FALSE)

show_ids <- read.table(opt$show_probs, sep="\t", head=T, row.names=1, check.names=F, quote="", stringsAsFactors=FALSE)

#incase too much point to show
show_ids <- head(rownames(show_ids),n=opt$max_point)


keyvals <- rep('grey', nrow(res))
names(keyvals) <- rep('NS', nrow(res))

keyvals[which(res$"deltaBeta" > 0 & res$"P.Value"<opt$pvalue)] <- 'red'
names(keyvals)[which(res$"deltaBeta" > 0 & res$"P.Value"<opt$pvalue)] <- 'HyperMethylation'

keyvals[which(res$"deltaBeta" < 0 & res$"P.Value"<opt$pvalue)] <- 'green'
names(keyvals)[which(res$"deltaBeta" < 0 & res$"P.Value"<opt$pvalue)] <- 'HypoMethylation'

#make all selected points being showed on figure
options(ggrepel.max.overlaps = Inf)

p <- EnhancedVolcano(res,
                    lab = rownames(res),
                    x = 'deltaBeta',
                    y = 'P.Value',
                    xlim = c(-1.2, 1.2),
                    ylim = c(0,15),
                    title = opt$versus_name,
                    pCutoff = opt$pvalue,
                    FCcutoff = 0,
                    xlab = bquote(~'Delta Beta'),
                    ylab = bquote(~-Log[10]~italic(P)~-Value),
                    subtitle = bquote(italic(Volcano~-Plot)),
                    selectLab = show_ids,
                    colAlpha = 1,
                    colCustom = keyvals,
                    cutoffLineType = "twodash",
                    cutoffLineCol = "black",
                    cutoffLineWidth = 0.6,
                    legendPosition = 'right',
                    drawConnectors = TRUE,
                    legendLabSize = 16,
                    legendIconSize = 5.0                    
                    )

pdf(file=paste(opt$oprefix,".pdf",sep=""), height=12, width=12)
print(p)
graph2ppt(p,file=paste(opt$oprefix,".pptx",sep=""))
dev.off()    
