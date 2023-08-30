#NJtree
plink  --bfile 159_cattle_snp_geno01_maf005_nchr --allow-extra-chr --chr-set 29  --genome
perl ~/script/MEGA/02_MEGA-meg.pl plink.genome 159_cattle_snp_geno01_maf005_nchr.fam 159_cattle_snp_geno01_maf005_nchr.meg

# PCA
gcta="/home/software/gcta_1.92.3beta3/gcta64"
$gcta --bfile 157_cattle_snp_geno01_maf005-ld502502_nchr.bim --make-grm --autosome-num 29 --out PCA_157_cattle_snp_geno01_maf005-ld502502_nchr.gcta
$gcta --grm PCA_157_cattle_snp_geno01_maf005-ld502502_nchr.gcta --pca 10 --out PCA_157_cattle_snp_geno01_maf005-ld502502_nchr.gcta.out

