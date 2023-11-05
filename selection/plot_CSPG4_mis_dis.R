## CSPG4错意突变分布
library(ggplot2)
library(patchwork)
phy.cols <- c("#93DAD1","#7290CC", "#9870CB")
df1 = read.table("33217035bp.txt", sep='\t', header=T)
df1$var <- factor(df1$var, levels=c("A", "G"))
p1 = ggplot(df1, aes(x=group,y= per, group=var,fill=var))+ 
  geom_bar(stat = "identity")+ 
  coord_flip()+
  labs(x="", y="") +
  scale_x_discrete(limits = unique(df1$group))+   
  scale_fill_manual(values=phy.cols) +
  scale_y_continuous(expand = c(0,0),labels = scales::percent_format(scale = 1))+
  theme_minimal()+
  theme(axis.text = element_text(face="bold"))+
  theme (axis.title.x = element_blank ()) +
  theme(legend.title=element_blank()) +
  theme(legend.position = "top") 


df2 = read.table("33215961bp.txt", sep='\t', header=T)
df2$var <- factor(df2$var, levels=c("A", "C"))
p2 = ggplot(df2, aes(x=group,y= per, group=var,fill=var))+ 
  geom_bar(stat = "identity")+ 
  coord_flip()+
  labs(x="", y="") +
  scale_x_discrete(limits = unique(df2$group))+   
  scale_fill_manual(values=phy.cols) +
  scale_y_continuous(expand = c(0,0),labels = scales::percent_format(scale = 1))+
  theme_minimal()+
  theme(axis.text = element_text(face="bold"))+
  theme (axis.title.x = element_blank ()) +
  theme(legend.title=element_blank()) +
  theme(legend.position = "top") 

df3 = read.table("33206681bp.txt", sep='\t', header=T)
df3$var <- factor(df3$var, levels=c("G", "T"))
p3 = ggplot(df3, aes(x=group,y= per, group=var,fill=var))+ 
  geom_bar(stat = "identity")+ 
  coord_flip()+
  labs(x="", y="") +
  scale_x_discrete(limits = unique(df3$group))+   
  scale_fill_manual(values=phy.cols) +
  scale_y_continuous(expand = c(0,0),labels = scales::percent_format(scale = 1))+
  theme_minimal()+
  theme(axis.text = element_text(face="bold"))+
  theme(legend.title=element_blank()) +
  theme(legend.position = "top") 

df4 = read.table("33211195bp.txt", sep='\t', header=T)
df4$var <- factor(df4$var, levels=c("G", "A"))
p4 = ggplot(df4, aes(x=group,y= per, group=var,fill=var))+ 
  geom_bar(stat = "identity")+ 
  coord_flip()+
  labs(x="", y="") +
  scale_x_discrete(limits = unique(df3$group))+   
  scale_fill_manual(values=phy.cols) +
  scale_y_continuous(expand = c(0,0),labels = scales::percent_format(scale = 1))+
  theme_minimal()+
  theme(axis.text = element_text(face="bold"))+
  theme(legend.title=element_blank()) +
  theme(legend.position = "top") 
p = p3 | p4 | p2 | p1 
p



library(ggplot2)
library(ggthemes)
library(patchwork)
phy.cols <- c("#93DAD1","#7290CC", "#9870CB")
data1 = read.table("4变异频率.txt", sep='\t', header=T)
data1$var <- factor(data1$var, levels=c("G", "T"))
p1 = ggplot(data1, aes(x=group,y= per, group=var,fill=var))+ 
  geom_bar(stat = "identity")+ 
  labs(x="", y="") +
  scale_x_discrete(limits = unique(data1$group))+   
  scale_fill_manual(values=phy.cols) +
  scale_y_continuous(expand = c(0,0),labels = scales::percent_format(scale = 1))+
  theme_minimal()+
  theme(axis.text = element_text(face="bold"))+
  theme(legend.title=element_blank())+
  theme(legend.position = "top") 

data1$var1 <- factor(data1$var1, levels=c("G", "A"))
p2 = ggplot(data1, aes(x=group1,y= per1, group=var1,fill=var1))+ 
  geom_bar(stat = "identity")+ 
  labs(x="", y="") +
  scale_x_discrete(limits = unique(data1$group1))+   
  scale_fill_manual(values=phy.cols) +
  scale_y_continuous(expand = c(0,0),labels = scales::percent_format(scale = 1))+
  theme_minimal()+
  theme(axis.text = element_text(face="bold"))+
  theme(legend.title=element_blank())+
  theme(legend.position = "top") 


data1$var2 <- factor(data1$var2, levels=c("A", "C"))
p3 = ggplot(data1, aes(x=group2,y= per2, group=var2,fill=var2))+ 
  geom_bar(stat = "identity")+ 
  labs(x="", y="") +
  scale_x_discrete(limits = unique(data1$group2))+   
  scale_fill_manual(values=phy.cols) +
  scale_y_continuous(expand = c(0,0),labels = scales::percent_format(scale = 1))+
  theme_minimal()+
  theme(axis.text = element_text(face="bold"))+
  theme(legend.title=element_blank())+
  theme(legend.position = "top") 

data1$var3 <- factor(data1$var3, levels=c("A", "G"))
p4 = ggplot(data1, aes(x=group3,y= per3, group=var3,fill=var3))+ 
  geom_bar(stat = "identity")+ 
  labs(x="", y="") +
  scale_x_discrete(limits = unique(data1$group3))+   
  scale_fill_manual(values=phy.cols) +
  scale_y_continuous(expand = c(0,0),labels = scales::percent_format(scale = 1))+
  theme_minimal()+
  theme(axis.text = element_text(face="bold"))+
  theme(legend.title=element_blank())+
  theme(legend.position = "top") 
p = p1 | p2 | p3 | p4
p
