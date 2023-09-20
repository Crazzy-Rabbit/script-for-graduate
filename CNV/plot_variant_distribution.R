library(ggplot2)
df = read.table("wagyu_all_dis.txt", sep='\t', header=T)

ggplot(df, aes(y= count, x = Type, fill = Region))+ ## 使用ggplot2语法
       geom_bar(stat = "identity", position = "stack",colour="black",width = 0.8)+ ## 添加柱子
       theme(panel.border = element_blank(),
             panel.grid.major = element_blank(), 
             panel.background = element_blank()) + #去除背景    
       theme(legend.position = "top") + 
       guides(fill = guide_legend( ncol = 4, byrow = F)) +
       theme(axis.text.y = element_text(face="bold"))+
       theme(axis.text.x = element_text(face="bold"))+
       labs(x="CNVRs type", y="Number of CNVRs") +
       scale_fill_brewer(palette = "Paired")## 添加柱子颜色
