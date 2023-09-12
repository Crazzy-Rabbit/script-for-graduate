library(ggalt)
library(ggplot2)

data = read.table("indel_length.txt",sep='\t',header=T)
data$Type <- factor(data$Type, levels=c("DEL", "DUP", "Both"))
phy.cols <- c( "#349839","#EA5D2D","#2072A8")
ggplot(data,aes(x=length,y=number,
                group=Type, colour=Type )) +
       geom_point(size=3)+
       labs(x="Distribution", y="Number of CNVRs")+
       geom_xspline(spline_shape = -0.5)+
       scale_x_discrete(limits=c("1-2kb","2-5kb","5-10kb","10-20kb","20-50kb","50-100kb", ">100kb"))+
       scale_colour_manual(values=phy.cols) +
       theme_bw() +
       theme(panel.border = element_rect(fill=NA,color="black", linewidth = 0.5, linetype ="solid"))
