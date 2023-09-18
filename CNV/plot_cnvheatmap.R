library(pheatmap)
group = read.table("sample_plot.list.txt", stringsAsFactors = F)
names(group) <- c("ID","Group")
rownames(group) <- group$ID
group$ID <- NULL

data2=read.table ("CNV.txt", header = TRUE, stringsAsFactors = F)
data2=data.matrix(data2)

annotation_row = data.frame(Group=as.vector(group$Group))
rownames(annotation_row) = rownames(data2)
ra_col <- list(Group=c(WAG="#873186", AH="#E20593"))
gap_line <- c(21)

pheatmap(data2, annotation_row=annotation_row, border_color=NA, annotation_colors=ra_col,
        cluster_row=FALSE,cluster_col=FALSE,gaps_row=gap_line,legend =FALSE,
        labels_col = rep("",ncol(data2)),labels_row=rep("",nrow(data2)),
        color=c("gold","#6BB93F","grey"), angle_col = "0")
