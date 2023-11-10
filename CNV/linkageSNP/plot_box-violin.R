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
