## outgroup f3
library(ggplot2)
data<-read.table("outgroupf3.f3", header=T, sep="\t")
data$max<-data$f_3+data$std.err
data$min<-data$f_3-data$std.err

m_colour=c("ANG"="#6BB93F","HOL"="#6BB93F","SIM"="#6BB93F",
           "SHO"="#6BB93F","CHR"="#6BB93F","HAW"="#873186",
           "KAZ"="#873186","MON"="#873181","YB"="#873181",
            "MIS"="#18A2CA","KUC"="#18A2CA")
p<-ggplot(data,aes(Source1,f_3, col=Source1))
p+geom_linerange(aes(ymin=min,ymax=max))+
  scale_x_discrete(limits = unique(data$Source1))+ 
  geom_point(aes(x=Source1,y=f_3),size=2,shape=0)+
  coord_flip()+ scale_color_manual(values=m_colour)+
  labs(x="",y="Outgroup f3 (Other, WAG; Outgroup)")+
  theme_bw() + 
  theme(strip.background =element_rect(fill="grey")) +
  guides(col=F)
