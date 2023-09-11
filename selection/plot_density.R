library(ggplot2)
data <- read.table("all.fst", sep="\t", header=T)
ggplot(data,aes(x=FST, group=Group, fill=Group))+
  geom_density(alpha=0.6,linetype=0)+
  labs(x=expression(paste(italic('F'),st)), y="Density")+
  theme_bw() +
  theme(legend.position = c(0.6,0.9))

library(ggplot2)
data <- read.table("all.lnratio", sep="\t", header=T)
ggplot(data,aes(x=lnratio, group=Group, fill=Group))+
  geom_density(trim=TRUE, alpha=0.6,linetype=0)+
  labs(x="-ln(θπ_W / θπ_AH)", y="Density")+
  theme_bw() +
  theme(legend.position = c(0.54,0.9))
  
library(ggplot2)
data <- read.table("all.XPEHH.txt", sep="\t", header=T)
ggplot(data,aes(x=XPEHH, group=Group, fill=Group))+
  geom_density(alpha=0.6,linetype=0,adjust=1.5)+
  labs(x="XP-EHH", y="Density")+
  theme_bw() +
  theme(legend.position = c(0.6,0.9))
