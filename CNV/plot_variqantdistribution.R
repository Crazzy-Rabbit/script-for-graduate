library(ggplot2)
df = read.table("3-anno.txt", sep='\t', header=T)
ggplot(df, aes(y= Number, x = type, fill = Dis))+
       geom_bar(stat = "identity", position = "stack", color = "black",width = 0.8)+
       theme(panel.border = element_blank(),
             panel.grid.major = element_blank(), 
             panel.background = element_blank(),) + 
       theme(legend.position = "top") + 
       guides(fill = guide_legend( ncol = 4, byrow = F)) +
       labs(x="CNVRs type", y="Number of CNVRs") +
       scale_fill_brewer(palette = "Paired")
