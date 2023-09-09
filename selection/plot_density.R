library(ggplot2)
data <- read.table("all.fst", sep="\t", header=T)
ggplot(data,aes(x=FST, group=Group, fill=Group))+
  geom_density(alpha=0.3,adjust=1.5)+
  theme_bw() +
  theme(legend.position = c(0.9,0.9))

library(ggplot2)
data <- read.table("all.lnratio", sep="\t", header=T)
ggplot(data,aes(x=lnratio, group=Group, fill=Group))+
  geom_density(alpha=0.3,adjust=1.5)+
  theme_bw() +
  theme(legend.position = c(0.9,0.9))
  
library(ggplot2)
data <- read.table("all.XPEHH.txt", sep="\t", header=T)
ggplot(data,aes(x=XPEHH, group=Group, fill=Group))+
  geom_density(alpha=0.3,adjust=1.5)+
  theme_bw() +
  theme(legend.position = c(0.9,0.9))
