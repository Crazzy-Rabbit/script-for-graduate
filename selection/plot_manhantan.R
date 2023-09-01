library(CMplot)
data1 <- read.table("wag_A-H-lnratio.txt",header = T,sep = '\t') 

color_set2 <- c('#1B2C62', '#4695BC')
CMplot(data1, plot.type="m", LOG10=F,
       chr.den.col=NULL, col = color_set2,
       threshold = 1.07010540666377, threshold.col = "red", 
       threshold.lwd= 2, threshold.lty =1,
       amplify = FALSE, file.output=T, height=5, width = 15,
       ylab = "-ln(θπ_W / θπ_AH)",
       pch =16, cex =0.5, dpi = 600, file = "jpg",memo = "pi")

library(CMplot)
data1 <- read.table("A_H-Wag.norm.XPEHH",header = T,sep = '\t') 
color_set2 <- c('#1B2C62', '#4695BC')

CMplot(data1, plot.type="m", LOG10=F,
       chr.den.col=NULL, col = color_set2,
       threshold = 1.4956, threshold.col = "red", 
       threshold.lwd= 2, threshold.lty =1,
       amplify = FALSE, file.output=T, height=5, width = 15,
       ylab = "XP-EHH",
       pch =16, cex =0.5, dpi = 600, file = "jpg",memo = "xpehh")
