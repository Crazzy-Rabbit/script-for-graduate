# 绘制散点样式的箱型图
library(ggplot2)
library(RColorBrewer)
a=read.table("all_cv_plot.txt",header=T)
a$K=factor(a$K, levels=c("2","3","4","5","6","7","8"))

ggplot(a,aes(x=K,y=admix))+  
geom_boxplot(outlier.shape = NA)+ #不显示离群点
geom_jitter(width = 0.2, alpha = 0.5) + #设置抖动的宽度和透明度
  labs(x="k",y = "cross-validation erro")+ 
  theme_classic() + 
  theme(panel.border = element_rect(fill=NA,color="black", 
                                  linewidth=0.5, linetype ="solid"))
