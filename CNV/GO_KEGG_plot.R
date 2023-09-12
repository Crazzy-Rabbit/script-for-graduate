library(ggplot2)
library(openxlsx)
kegginput <- read.xlsx("go.xlsx")

x=kegginput$logp
y=factor(kegginput$Term,levels = kegginput$Term)
p = ggplot(kegginput,aes(x,y))
p1 = p + geom_point(aes(size=Count,color=-0.5*log(pvalue)))+
    # scale_color_gradient(low = "BLUE", high = "OrangeRed") +
      scale_color_gradient(low = "SpringGreen", high = "OrangeRed") +
     theme_bw() +
     theme(panel.border = element_rect(fill=NA,color="black", size=0.5, linetype ="solid"))

p2 = p1 + labs(color=expression(-log[10](pvalue)),
               size="Count",x="",y="",title="")
p2
