  ## CNV PCA 380 360
  library("ggplot2")
  a=read.table("PCA.gcta.out.eigenvec",header=F)
  Breed=a[,1] 
  PC1=a[,3]
  PC2=a[,4]
  m_shape=c("Wagyu"=21,"Angus"=22,"Holstein"=24)
  
  ggplot(data=a,aes(x=PC1, y=PC2,group=Breed,
                    shape=Breed,color=Breed,fill=Breed))+
    geom_point(size=5,alpha=0.8,stroke=1,color="black")+
    scale_shape_manual(values=m_shape)+
    labs(x = "PC1(24.49%)", y = "PC2(12.23%)")+ 
    theme_classic() +
    geom_hline(yintercept = 0, linetype = "dashed", color = "black") +
    geom_vline(xintercept = 0, linetype = "dashed", color = "black") +
    theme(legend.position =c(0.15,0.85),legend.title=element_blank())+
    theme(panel.border = element_rect(fill=NA,color="black", size=0.5, linetype ="solid"))

  library("ggplot2")
  a=read.table("dup.gcta.out.eigenvec",header=F)
  Breed=a[,1] 
  PC1=a[,3]
  PC2=a[,4]
  m_shape=c("Wagyu"=21,"Angus"=22,"Holstein"=24)
  ggplot(data=a,aes(x=PC1, y=PC2,group=Breed,
                         shape=Breed,color=Breed,fill=Breed))+
    geom_point(size=5,alpha=0.8,stroke=1,color="black")+
    scale_shape_manual(values=m_shape) +
    labs(x = "PC1(30.66%)", y = "PC2(7.27%)")+ 
    theme_classic() +
    geom_hline(yintercept = 0, linetype = "dashed", color = "black") +
    geom_vline(xintercept = 0, linetype = "dashed", color = "black") +
    theme(legend.position =c(0.15,0.85),legend.title=element_blank())+
    theme(panel.border = element_rect(fill=NA,color="black", size=0.5, linetype ="solid"))

  library("ggplot2")
  a=read.table("dup.gcta.out.eigenvec",header=F)
  Breed=a[,1] 
  PC1=a[,3]
  PC2=a[,4]
  m_shape=c("Wagyu"=21,"Angus"=22,"Holstein"=24)
  
  ggplot(data=a,aes(x=PC1, y=PC2,group=Breed,
                         shape=Breed,color=Breed,fill=Breed))+
    geom_point(size=5,alpha=0.8,stroke=1,color="black")+
    scale_shape_manual(values=m_shape) +
    labs(x = "PC1(27.72%)", y = "PC2(14.96%)")+ 
    theme_classic() +
    geom_hline(yintercept = 0, linetype = "dashed", color = "black") +
    geom_vline(xintercept = 0, linetype = "dashed", color = "black") +
    theme(legend.position =c(0.15,0.85),legend.title=element_blank())+
    theme(panel.border = element_rect(fill=NA,color="black", size=0.5, linetype ="solid"))
    
