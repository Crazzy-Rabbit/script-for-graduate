# -ln(piwa/pia-h)
vcftools --vcf 61_cattle_geno01_maf005_nchr.vcf --window-pi 50000 --window-pi-step 25000 --keep A_H.txt --out A_H
vcftools --vcf 61_cattle_geno01_maf005_nchr.vcf --window-pi 50000 --window-pi-step 25000 --keep wagyu.txt --out wag
python /home/sll/script/selection/ln_ratio.py --group1 wag.windowed.pi --group2 A_H.windowed.pi --nvars 1 --outprefix wag_A-H-lnratio
# sort get first 5% and wag.windowed.pi last 5%
sort -gr -k 4  wag_A-H-lnratio.txt > wag_A-H-lnratio.sorted.txt
sort -g -k 5 wag.windowed.pi > wag.windowed.sorted.pi 
head -n 4973 wag_A-H-lnratio.sorted.txt > wag_A-H-lnratio.sorted.5%.txt
head -n 4974 wag.windowed.sorted.pi > wag.windowed.sorted.5%.pi
# cat 2 file
cat wag.windowed.sorted.5%.pi wag_A-H-lnratio.sorted.5%.txt > wag5%_wag_A-H5%.pi
