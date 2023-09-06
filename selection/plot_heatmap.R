# 不同组之间有缝隙，更加直观
library(pheatmap)
group = read.table("sample_plot.list.txt", stringsAsFactors = F) ##两列，1：ID，2：品种
names(group) <- c("ID","Group")
rownames(group) <- group$ID
group$ID <- NULL
new_order <- c("Wagyu", "Angus", "Holstein") # 新的组顺序
group$Group <- factor(group$Group, levels = new_order)

data2=read.table ("chr21-3320-33285.recode.vcf", header = TRUE, stringsAsFactors = F) # 转置后的文件
data2=data.matrix(data2)

annotation_row = data.frame(Group=as.vector(group$Group))
rownames(annotation_row) = rownames(data2)
ra_col <- list(Group=c(Wagyu="#873186", Angus="#E20593",  Holstein="#6BB93F"))
#"#3364BC", "#000000", "#F37020", "#DBB71D"
gap_line <- c(20,40) # 数量划分，根据图例顺序，分开每组的热图

pheatmap(data2, annotation_row=annotation_row, annotation_colors=ra_col,
        cluster_row=FALSE,cluster_col=FALSE,gaps_row=gap_line,legend =FALSE,
        labels_col = rep("",ncol(data2)),labels_row=rep("",nrow(data2)),
        color=c("#F7F8D5","#BF3826"), angle_col = "0")



library(pheatmap)
group = read.table("sample_plot.list.txt", stringsAsFactors = F) ##两列，1：ID，2：品种
names(group) <- c("ID","Group")
rownames(group) <- group$ID
group$ID <- NULL
new_order <- c("Wagyu", "Mishima", "KUC", "Haw", "mon", "kaz", "yb", "ang", "hol", "char", "sho","sim") # 新的组顺序
group$Group <- factor(group$Group, levels = new_order)

data2=read.table ("4variant.txt", header = TRUE, stringsAsFactors = F) # 转置后的文件
data2=data.matrix(data2)

annotation_row = data.frame(Group=as.vector(group$Group))
rownames(annotation_row) = rownames(data2)
ra_col <- list(Group=c(Wagyu="#873186", Mishima="#E20593",  KUC="#6BB93F",
                       Haw="#873186", mon="#E20593",  kaz="#6BB93F", yb="#873186",
                       ang="#E20593", hol="#6BB93F", char="#873186", sho="#E20593",sim="#6BB93F"))
#"#3364BC", "#000000", "#F37020", "#DBB71D"
gap_line <- c(21,30,72) # 数量划分，根据图例顺序，分开每组的热图

pheatmap(data2, annotation_row=annotation_row, border_color=NA, annotation_colors=ra_col,
        cluster_row=FALSE,cluster_col=FALSE,gaps_row=gap_line,legend =FALSE,
        labels_col = rep("",ncol(data2)),labels_row=rep("",nrow(data2)),
        color=c("grey","gold","#6BB93F"), angle_col = "0")
