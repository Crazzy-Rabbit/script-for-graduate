############## fst   ################
vcftools --vcf 61_cattle_geno01_maf005_nchr.vcf --weir-fst-pop A_H.txt --weir-fst-pop wagyu.txt --fst-window-size 50000 --fst-window-step 25000 --out wag_A-H
## sort get first 5%
sort -gr -k 5 wag_A-H.windowed.weir.fst  > wag_A-H.windowed.weir.sorted.fst 
head -n 4974 wag_A-H.windowed.weir.sorted.fst  > wag_A-H.windowed.weir.sorted.5%.fst 
############## pi   ################
## -ln(piwa/pia-h)
vcftools --vcf 61_cattle_geno01_maf005_nchr.vcf --window-pi 50000 --window-pi-step 25000 --keep A_H.txt --out A_H
vcftools --vcf 61_cattle_geno01_maf005_nchr.vcf --window-pi 50000 --window-pi-step 25000 --keep wagyu.txt --out wag
python /home/sll/script/selection/ln_ratio.py --group1 wag.windowed.pi --group2 A_H.windowed.pi --nvars 1 --outprefix wag_A-H-lnratio
## sort get first 5% and wag.windowed.pi last 5%
sort -gr -k 4  wag_A-H-lnratio.txt > wag_A-H-lnratio.sorted.txt
sort -g -k 5 wag.windowed.pi > wag.windowed.sorted.pi 
head -n 4973 wag_A-H-lnratio.sorted.txt > wag_A-H-lnratio.sorted.5%.txt
head -n 4974 wag.windowed.sorted.pi > wag.windowed.sorted.5%.pi
## cat 2 file
cat wag.windowed.sorted.5%.pi wag_A-H-lnratio.sorted.5%.txt > wag5%_wag_A-H5%.pi
############## xpehh ################
# beagle
java -jar -Xmn48G -Xms48G -Xmx96G /public/home/sll/software/beagle.25Nov19.28d.jar gt=61_cattle_geno01_maf005_nchr.vcf out=61_cattle_geno01_maf005_nchr.beagle ne=61
## /home/sll/20230818-sll-vcf/selection/xpehh
mkdir XP-EHH.progress
vcftools --gzvcf 61_cattle_geno01_maf005_nchr.beagle.vcf.gz --keep /home/sll/20230818-sll-vcf/selection/A_H.txt --recode --recode-INFO-all --out ./XP-EHH.progress/01.A_H
vcftools --gzvcf 61_cattle_geno01_maf005_nchr.beagle.vcf.gz --keep /home/sll/20230818-sll-vcf/selection/wagyu.txt --recode --recode-INFO-all --out ./XP-EHH.progress/01.Wag

cd XP-EHH.progress
for ((k=1; k<=29; k++)); do 
vcftools --vcf 01.A_H.recode.vcf --recode --recode-INFO-all --chr ${k} --out A_H.chr${k}
vcftools --vcf 01.Wag.recode.vcf --recode --recode-INFO-all --chr ${k} --out Wag.chr${k}                  
vcftools --vcf A_H.chr${k}.recode.vcf --plink --out chr${k}.MT
awk 'BEGIN{OFS=" "} {print $1,".",$4,$4}' chr${k}.MT.map > chr${k}.MT.map.distance
done
selscan="/home/software/selscan/bin/linux/selscan"
norm="/home/software/selscan/bin/linux/norm"
for ((k=1; k<=29; k++)); do
$selscan --xpehh --vcf Wag.chr${k}.recode.vcf --vcf-ref A_H.chr${k}.recode.vcf --map chr${k}.MT.map.distance --threads 10 --out  chr${k}.A_H-Wag          
$norm --xpehh --files  chr${k}.A_H-Wag.xpehh.out --bp-win --winsize 50000
# add win and step
python ~/script/selection/XPEHH_Win_step.py --file chr${k}.A_H-Wag.xpehh.out.norm --chrosome $k --window 50000 --step 25000
done
cat {1..29}.XPEHH > ../A_H-Wag.norm.XPEHH
## sort get first 5%
sort -gr -k 5 A_H-Wag.norm.XPEHH > A_H-Wag.norm.sorted.XPEHH
head -n 4972 A_H-Wag.norm.sorted.XPEHH > A_H-Wag.norm.sorted.5%.XPEHH
######################################
# intersect 
bedtools intersect -a wag_A-H.windowed.weir.sorted.5%.fst -b wag_A-H-lnratio.sorted.5%.txt > wag_A-H.sorted.5%.fst.lnratio
bedtools intersect -a wag_A-H.sorted.5%.fst.lnratio -b A_H-Wag.norm.sorted.5%.XPEHH > wag_A-H.sorted.5%.fst.lnratio.xpehh
awk '{print $1"\t"$2"\t"$3}' wag_A-H.sorted.5%.fst.lnratio.xpehh > wag_A-H.sorted.5%.fst.lnratio.xpehh.pos
######################################
# biomart annotation
bedtools intersect -a wag_A-H.sorted.5%.fst.lnratio.xpehh -b /home/sll/Biomart/biomart_20257_release110_July_2023.txt -wao > wag_A-H.sorted.5%.fst.lnratio.xpehh.pos.biomart.gene
######################################
