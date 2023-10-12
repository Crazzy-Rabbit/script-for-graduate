### 组合图
data1 <- read.table("wag_A-H.windowed.weir.fst",sep='\t', header = TRUE)
data2 <- read.table("A_H-Wag.norm.XPEHH",sep='\t', header = TRUE)
data3 <- read.table("wag_A-H-lnratio.txt", sep='\t', header = TRUE)

merged_data <- merge(merge(data1,data2,by=c("CHR","BP")), 
                     data3, by=c("CHR","BP"))
input_data <- merged_data[,c(3,1,2,4,6,8)]
names(input_data) <- c("SNP","CHR","BP","fst","XPEHH","pi")
# 生成冷色调的渐变色
color_pal <- rev(colorRampPalette(brewer.pal(n=11, name = "Spectral"))(10))
color_selection <- color_pal[c(1, 2, 3, 8, 9)] # 1-10都代表一种颜色

# 绘制组合图
library(ggplot2)
ggplot(data = input_data, aes(x=fst, y=pi)) + 
  geom_point(aes(color = XPEHH), alpha = 0.8, size = 4) +
  geom_point(shape = NA) + 
  scale_color_gradientn(colors = color_selection) +
  labs(x=expression(paste(italic('F'),st)),
       y="-ln(θπ_W / θπ_AH)") +
  geom_hline(yintercept = 1.0701, linetype = "dashed", color = "black") +
  geom_vline(xintercept = 0.393674, linetype = "dashed", color = "black") +
  theme_classic()+
  theme(panel.border = element_rect(fill=NA, color="black", linetype ="solid"))
