# 500 300
# indel
library(ggplot2)
library(ggbreak)
data = read.table("indel_length.txt",sep='\t',header=T)
m_cols <- c("#93DAD1","#7290CC","#9870CB")

ggplot(data,aes(x=length, y=number,fill="#93DAD1", colour="#9870CB"))+
  geom_bar(stat ="identity",fill="#93DAD1",colour="#9870CB")+
  theme_classic()+
  labs(x="InDels length(bp)", y="InDels count")+
  theme(axis.text.x.top=element_blank(),
        axis.line.x.top=element_blank())+
  theme(axis.text.y.right = element_blank(),
        axis.ticks.y.right = element_blank())+
  theme(axis.text.y = element_text(face="bold"))+
  theme(axis.text.x = element_text(face="bold"))+
  theme(legend.position="none")+
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))+
  scale_y_break(c(4000,5000),space=0.2,
                scales=1,expand=c(0,0))

# freq 500 200
library(ggplot2)
data = read.table("indel_freq.txt",sep='\t',header=T)
ggplot(data, aes(x=Chr,y=indel,colour="black", fill="#9870CB",))+
 # geom_line(colour="#9870CB")+
  geom_xspline(colour="#9870CB",spline_shape = -0.5)+
  geom_point(colour="black", fill="#9870CB",size=2, shape=23)+
  expand_limits(y = 0.2) +
  theme_bw()+
  theme(axis.text.y = element_text(face="bold"))+
  theme(axis.text.x = element_text(face="bold"))+
  labs(x="Chromosome", y="InDels/Kb")+
  scale_x_continuous(expand=c(0.02,0),
                     breaks = c(seq(1,29, by=2)))


### SNP 
# freq  500 200
library(ggplot2)
data = read.table("snp_freq.txt",sep='\t',header=T)
ggplot(data, aes(x=Chr,y=snp,fill="#7290CC",colour="black"))+
  geom_xspline(colour="#7290CC",spline_shape = -0.5)+
  geom_point(fill="#7290CC",colour="black",size=2, shape=21)+
  expand_limits(y = 2) +
  theme(axis.text.y = element_text(face="bold"))+
  theme(axis.text.x = element_text(face="bold"))+
  theme_bw()+
  labs(x="Chromosome", y="SNPs/Kb")+
  scale_x_continuous(expand=c(0.02,0),
                    breaks = c(seq(1,29, by=2)))

## tstv
library(ggplot2)
data = read.table("tstv.txt",sep='\t',header=T)
data$ts <- factor(data$ts, level=c("G/T","C/G","A/T","A/C","C/T","A/G"))
m_cols <- c("A/G"="#93DAD1","C/T"="#93DAD1",
            "A/C"="#9870CB","A/T"="#9870CB","C/G"="#9870CB","G/T"="#9870CB")

ggplot(data, aes(x=ts,y=count, col=ts,fill=ts))+
  geom_bar(stat = "identity",position="stack",width=0.5)+
  theme_bw()+
  theme(axis.text.y = element_text(face="bold"))+
  theme(axis.text.x = element_text(face="bold"))+
  theme(legend.position="none")+
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))+
  #scale_colour_manual(values=m_cols)+
  scale_fill_manual(values=m_cols)+
  coord_flip()+
  labs(x="Ts/Tv Type", y="SNPs Count")
  
  
## 在基因组位置 500 400
library(ggplot2)
library(ggbreak)
library(RColorBrewer)
data = read.table("snpindel_vardis.txt",sep='\t',header=T)
data$Region <- factor(data$Region, level=c("ncRNA_splicing","splicing","UTR5","ncRNA_exonic","UTR3","upstream",
                                           "downstream","exonic","ncRNA_intronic","intronic","intergenic"))
m_col = c("#EEBB47","#D8793F",
          "#EA5D2D","#C63581","#349839",
          "#6A3D9A","#2F71A7","#C477A6","#93DAD1","#9870CB","#6DB0D7")

ggplot(data, aes(x=Region, y=snp, fill=Region))+
  geom_bar(stat = "identity",position="stack")+
  scale_y_continuous(labels=function(x) format(x, scientific = FALSE))+
  scale_fill_manual(values=m_col2)+
  theme_classic()+
  theme(legend.position="none")+
  scale_y_break(c(1000,10000),space=0.2,
                scales=1,expand=c(0,0))+
  scale_y_break(c(100000,250000),space=0.2,
                scales=1,expand=c(0,0))+
  theme(axis.text.x.top=element_blank(),axis.line.x.top=element_blank(),
        axis.text.x = element_text(face="bold",angle=45,hjust = 1))+
  theme(axis.text.y.right=element_blank(),axis.ticks.y.right=element_blank(),
        axis.text.y = element_text(face="bold"))+
  labs(x="",y="SNPs Number")

# indel
ggplot(data, aes(x=Region, y=indel, fill=Region))+
  geom_bar(stat = "identity",position="stack")+
  scale_y_continuous(labels=function(x) format(x, scientific = FALSE))+
  scale_fill_manual(values=m_col)+
  theme_classic()+
  theme(legend.position="none")+
  scale_y_break(c(10000,20000),space=0.2,
                scales=1,expand=c(0,0))+
  theme(axis.text.x.top=element_blank(),axis.line.x.top=element_blank(),
        axis.text.x = element_text(face="bold",angle=45,hjust = 1))+
  theme(axis.text.y.right=element_blank(),axis.ticks.y.right=element_blank(),
        axis.text.y = element_text(face="bold"))+
  labs(x="",y="InDels Number")

### percentage 
library(ggplot2)
data = read.table("snpindel_percentage.txt",sep='\t',header=T)
data$type <- factor(data$type, level=c("InDels","SNPs"))
data$Region <- factor(data$Region, level=c("ncRNA_splicing","splicing","UTR5","ncRNA_exonic","UTR3","upstream",
                                           "downstream","exonic","ncRNA_intronic","intronic","intergenic"))
m_col = c("#EEBB47","#D8793F",
          "#EA5D2D","#C63581","#349839",
          "#6A3D9A","#2F71A7","#C477A6","#93DAD1","#9870CB","#6DB0D7")

ggplot(data,aes(x=per,y=type,group=type,fill=Region))+
  geom_bar(stat = "identity")+
 # coord_flip()+
  scale_fill_manual(values=m_col)+
  theme_minimal()+
  theme(legend.position="left")+
  guides(fill=guide_legend(title=NULL,ncol=3, byrow=T,reverse=T),)+
  theme(axis.text.x=element_text(face="bold"))+
  theme(axis.text.y=element_text(face="bold"))+
  labs(x="Percentage(%)",y="")
  




