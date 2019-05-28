#/usr/bin/env Rscript
library('optparse')

option_list = list(
                make_option(c('-i','--in_file1'),type='character',default=NULL,help='input file1 for Venn',metavar="character"),
                make_option(c('-j','--in_file2'),type='character',default=NULL,help='input file2 for Venn',metavar="character"),
                make_option(c('-o','--out_file'),type='character',default='venn.png',help="output picture name [default= %default]",metavar="character")
               );
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)



if(is.null(c(opt$in_file1,opt$in_file2))){
    print_help(opt_parser);
    stop('input file1 or file2 missing ,please check', call. = FALSE)
}


library('VennDiagram')

lista<-read.table(opt$in_file1,header = T,check.name=FALSE)

listb<-read.table(opt$in_file2,header = T,check.name=FALSE)


venn.diagram(c(as.list(lista),as.list(listb)),resolution = 400,lwd=4,ext.line.lwd = 0,
             height = 2000, width = 2000,units='px',margin=0.15,
             cat.fontface=4,main.cex = 0.5,cat.cex=1,
             main.fontfamily = "serif",cex = 1,fill = c("green", "orange"),
             imagetype="png",
             filename = opt$out_file,
             cat.dist = c(-0.050, 0.050),
             cat.pos=c(-75,0))



#scaled=0


