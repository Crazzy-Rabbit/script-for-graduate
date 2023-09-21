# 190 330
library(ggplot2)
data <- read.table("all.fst", sep="\t", header=T)
data$Group <- factor(data$Group, levels=c("Simulated","Observed "))  
ggplot(data,aes(x=FST, group=Group, fill=Group))+
  geom_density(alpha=0.6,linetype=0)+
  labs(x=expression(paste(italic('F'),st)), y="Density")+
  guides(fill = guide_legend(ncol = 1, byrow = F,title = "")) +
  scale_y_continuous(expand = c(0,0))+
  theme_bw() +
  theme(legend.position = "top")

library(ggplot2)
data <- read.table("all.lnratio", sep="\t", header=T)
data$Group <- factor(data$Group, levels=c("Simulated","Observed"))  
ggplot(data,aes(x=lnratio, group=Group, fill=Group))+
  geom_density(trim=TRUE, alpha=0.6,linetype=0)+
  labs(x="-ln(θπ_W / θπ_AH)", y="Density")+
  guides(fill = guide_legend(ncol = 1, byrow = F,title = "")) +
  scale_y_continuous(expand = c(0,0))+
  theme_bw() +
  theme(legend.position = "top")
  
library(ggplot2)
data <- read.table("all.XPEHH.txt", sep="\t", header=T)
data$Group <- factor(data$Group, levels=c("Simulated","Observed"))  
ggplot(data,aes(x=XPEHH, group=Group, fill=Group))+
  geom_density(alpha=0.6,linetype=0,adjust=1.5)+
  labs(x="XP-EHH", y="Density")+
  guides(fill = guide_legend(ncol = 1, byrow = F,title = "")) +
  scale_y_continuous(expand = c(0,0))+
  theme_bw() +
  theme(legend.position = "top")
