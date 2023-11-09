bcftools view -R /home/sll/2023-CNV-wagyu/08.correct_CNV/fst/CNV.29chr.region.estract.snp 61_cattle_geno01_maf005_nchr.vcf.gz > 61_cattle_geno01_maf005_nchr.snp-cnv.vcf

PopLDdecay -InVCF 61_cattle_geno01_maf005_nchr.snp-cnv.vcf -OutStat 61_cattle_geno01_maf005_nchr.snp-cnv.stat -MaxDist 50 -OutType 3

python extractLDofCNV.py
