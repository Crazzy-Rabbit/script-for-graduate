# the fst of SNP flank all CNV and selection CNV
bcftools view -R /home/sll/2023-CNV-wagyu/08.correct_CNV/fst/CNV.29chr.region.estract.snp /home/sll/20230818-sll-vcf/selection/61_cattle_geno01_maf005_nchr.vcf.gz > CNV-all.snp.vcf
vcftools --vcf  CNV-all.snp.vcf --weir-fst-pop /home/sll/20230818-sll-vcf/selection/A_H.txt --weir-fst-pop /home/sll/20230818-sll-vcf/selection/wagyu.txt --fst-window-size 5000 --fst-window-step 5000 --out all-cnv

awk '{print $1"\t"$2-50000"\t"$2}' wagyu-angus_hostein.vst_0.5.txt > CNV-slection_start.txt
awk '{print $1"\t"$3"\t"$3+50000}' wagyu-angus_hostein.vst_0.5.txt > CNV-slection_end.txt
cat CNV-slection_start.txt CNV-slection_end.txt > CNV-slection_region.txt
bcftools view -R CNV-slection_region.txt /home/sll/20230818-sll-vcf/selection/61_cattle_geno01_maf005_nchr.vcf.gz > CNV-selection.snp.vcf
vcftools --vcf CNV-selection.snp.vcf --weir-fst-pop /home/sll/20230818-sll-vcf/selection/A_H.txt --weir-fst-pop /home/sll/20230818-sll-vcf/selection/wagyu.txt --fst-window-size 5000 --fst-window-step 5000 --out CNV-selection
