### 毕业论文PCA图脚本
library(ggplot2)
library(scales)

a = read.table("PCA_157_cattle_snp_geno01_maf005-ld502502_nchr.gcta.out.eigenvec",header=F)
m = as.matrix(read.table("PCA_157_cattle_snp_geno01_maf005-ld502502_nchr.gcta.out.eigenval",header=F))

explainm = m/sum(m)
pc1 = paste("PC1","(",percent(explainm[1,], accuracy=0.01),")", sep="")
pc2 = paste("PC2","(",percent(explainm[2,], accuracy=0.01),")", sep="")
Breed=a[,1]; PC1=a[,3]; PC2=a[,4]; PC3=a[,5] 
a$V1 = factor(a$V1,levels=c("ANG","HOL","SIM","SHO","CHR","HAW","KAZ","MON","YB","KUC","MIS","WAG","WL","BRA"))

m_color = c("ANG"="#6BB93F","HOL"="#6BB93F","SIM"="#6BB93F","SHO"="#6BB93F","CHR"="#6BB93F","HAW"="#873186",
             "KAZ"="#873186","MON"="#873181","YB"="#873181","MIS"="#18A2CA","KUC"="#18A2CA","WAG"="#E20593",
             "WL"="#DBB71D","BRA"="#b35107")
m_shape = c("ANG"=21,"HOL"=21,"SIM"=21,"SHO"=21,"CHR"=21,"HAW"=21,"KAZ"=21,"MON"=21,"YB"=21,"MIS"=25,"KUC"=24,
            "WAG"=22,"WL"=23,"BRA"=23)
p = ggplot(data=a, aes(x=PC1, y=PC2,group=Breed,
                       shape=Breed,color="black",fill=Breed))+
      geom_point(size=5,alpha=0.9,stroke=0.2,color="black") + 
      scale_color_manual(values=m_color)+
      scale_fill_manual(values=m_color)+ 
      scale_shape_manual(values=m_shape) 
p + labs(x = pc1, y = pc2)+ 
      geom_hline(yintercept=0,linetype="dashed",color="black")+
      geom_vline(xintercept=0,linetype="dashed",color="black")+
      theme_classic()+
      theme(panel.border = element_rect(fill=NA,color="black",linewidth=0.5,linetype ="solid"))+
      guides(color = guide_legend(override.aes = list(size=4, stroke=3)))+
      theme(legend.title = element_blank())
