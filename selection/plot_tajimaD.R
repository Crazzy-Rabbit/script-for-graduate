###### tajimaD

library(ggplot2)
data <- read.table("A-H.Tajima.D",sep='\t', header = TRUE)

p = ggplot(data,aes(BIN_START,TajimaD,group=group,color=group,shape=group))+
           geom_line(cex=1)

p1 = p + annotate("rect", xmin=33.20, xmax=33.21, ymin=-Inf, ymax=Inf, fill='gray',alpha = 0.3)+
         annotate("rect", xmin=33.27, xmax=33.275, ymin=-Inf, ymax=Inf, fill='gray',alpha = 0.3)

p1 + geom_hline(yintercept=0, linetype = "dashed", color = "black")+
     labs(x="Chromosome 21 (Mb)", y="Tajima's D")+
     theme_classic()+ # 去除灰色背景及网格线
     theme(panel.border=element_rect(fill=NA,color="black",linetype ="solid"))+ #添加边框
     theme(legend.position = "none")
