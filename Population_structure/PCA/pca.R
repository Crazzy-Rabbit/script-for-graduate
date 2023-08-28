  library("ggplot2")
  a=read.table("PCA_157_cattle_snp_geno01_maf005-ld502502_nchr.gcta.out.eigenvec",header=F)
  Breed=a[,1] 

  m_colour=c("ANG"="#6BB93F","HOL"="#6BB93F","SIM"="#6BB93F","SHO"="#6BB93F","CHR"="#6BB93F",
             "MIS"="#18A2CA","KUC"="#18A2CA","WAG"="#E20593","HAW"="#873186","KAZ"="#873186",
             "MON"="#873181","YB"="#873181","WL"="#DBB71D","BRA"="#b35107")
  m_shape=c("ANG"=21,"HOL"=21,"SIM"=21,"SHO"=21,"CHR"=21,
            "MIS"=25,"KUC"=24,"WAG"=22,"HAW"=21,"KAZ"=21,
            "MON"=21,"YB"=21,"WL"=21,"BRA"=21)
  
  p = ggplot(data  = a, aes(x = a[,3], y = a[,4],
            group=Breed,shape=Breed,color=Breed,fill=Breed))+
      geom_point(size=3,alpha = 0.15,stroke=1) + 
      scale_color_manual(values=m_colour)+
      scale_fill_manual(values=m_colour) + 
      scale_shape_manual(values=m_shape) 
  
  p + labs(x = "PC1(12.18%)", y = "PC2(6.82%)") + 
      geom_hline(yintercept = 0, linetype = "dashed", color = "black") +
      geom_vline(xintercept = 0, linetype = "dashed", color = "black") + 
      theme_classic() + # 去除灰色背景及网格线
      theme(panel.border = element_rect(fill=NA,color="black", size=0.5, linetype ="solid")) +#添加边框
      theme(legend.position = "none")
