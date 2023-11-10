library(ggplot2)
library(ggthemes)
a=read.table("chart-selection_all-CNV.txt",header=T)

ggplot(a,aes(x=G,y=FST, fill=G))+
  geom_violin()+
  geom_boxplot(fill = "white",  size = 1,  width = .2)+
  geom_hline(yintercept = 0.4318, linetype = "dashed", color = "black")+
  labs(x="",y=expression(paste(italic('F')[ST],'-SNP')))+
  theme_few()+
  theme(legend.position = "none")+
  theme(axis.text = element_text(face="bold"))

## Wilcoxon秩和检验,检查两组数据平均值是否有显著性
all = read.table("all-cnv.windowed.weir.fst",header=T)
select = read.table("CNV-selection.windowed.weir.fst",header=T)

x = all$WEIGHTED_FST
y = select$WEIGHTED_FST
wilcox.test(x,y,alternative="less",exact=FALSE,correct=FALSE)
