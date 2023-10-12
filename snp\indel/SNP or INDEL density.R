library("CMplot")
data1 <- read.table("FILE3.txt",sep='\t', header = TRUE)
data2 <- read.table("pi.QC.wagyu.indels_pass.recode_geno01_maf005.29chr.vcf.windowed.pi",sep='\t', header = TRUE)
data3 <- read.table("pi.QC.wagyu.snps_pass.recode_geno01_maf005.29chr.vcf.windowed.pi", sep='\t', header = TRUE)

merged_data <- merge(merge(data1, data2, 
                           by=c("CHR","BP")), 
                     data3, by=c("CHR","BP"))
input_data <- merged_data[,c(3,1,2,4,6,8)]

######## 绘图
CMplot(input_data,type="p",plot.type="c",LOG10=FALSE,outward=TRUE,
       
       chr.labels=paste("Chr",c(1:29),sep=""),threshold=NULL,r=1.5,cir.chr.h=1.5,
       cir.band=1,file="jpg", dpi=600,chr.den.col="black",
       file.output=T,verbose=TRUE,width=10,height=10)
