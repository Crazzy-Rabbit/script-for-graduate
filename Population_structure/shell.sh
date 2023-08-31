~/20230818-sll-vcf/structure
#################### NJtree ###########################
plink --bfile 159_cattle_snp_geno01_maf005_nchr --allow-extra-chr --chr-set 29  --genome
perl ~/script/MEGA/02_MEGA-meg.pl plink.genome 159_cattle_snp_geno01_maf005_nchr.fam 159_cattle_snp_geno01_maf005_nchr.meg
#################### MLtree ###########################
iqtree="~/software/iqtree-1.6.12/bin/iqtree"
# ld过滤
plink --allow-extra-chr --chr-set 29 -vcf 159_cattle_snp_geno01_maf005.vcf --set-missing-var-ids @:# --indep-pairwise 50 25 0.2 --out 159_cattle_snp_geno01_maf005_ld502502
plink --allow-extra-chr --chr-set 29 -vcf 159_cattle_snp_geno01_maf005.vcf --set-missing-var-ids @:# --extract 159_cattle_snp_geno01_maf005_ld502502.prune.in --recode vcf-iid --out 159_cattle_snp_geno01_maf005_ld502502
# iqtree
plink --allow-extra-chr --chr-set 29 --vcf 159_cattle_snp_geno01_maf005_ld502502.vcf.gz --recode --out 159_cattle_snp_geno01_maf005_ld502502
python ~/script/ped2fa.py 159_cattle_snp_geno01_maf005_ld502502.ped 159_cattle_snp_geno01_maf005_ld502502.fa
$iqtree -s 159_cattle_snp_geno01_maf005_ld502502.fa -m TEST -st DNA -bb 1000 -nt AUTO
# raxml
python ~/script/vcf2phylip.py --input 159_cattle_snp_geno01_maf005_ld502502.vcf.gz --output-prefix 159_cattle_snp_geno01_maf005_ld502502
raxmlHPC-PTHREADS-SSE3 -f a -m GTRGAMMA -p 23 -x 123 -# 100 -s 159_cattle_snp_geno01_maf005_ld502502.min4.phy  -o SRR14339798,SRR14416027 -n 159_cattle_snp_geno01_maf005 -T 20
####################### PCA ###########################
gcta="/home/software/gcta_1.92.3beta3/gcta64"
$gcta --bfile 157_cattle_snp_geno01_maf005-ld502502_nchr.bim --make-grm --autosome-num 29 --out PCA_157_cattle_snp_geno01_maf005-ld502502_nchr.gcta
$gcta --grm PCA_157_cattle_snp_geno01_maf005-ld502502_nchr.gcta --pca 10 --out PCA_157_cattle_snp_geno01_maf005-ld502502_nchr.gcta.out
############# admixture with 20 bootstrap #############
if [ $# -ne 3 ]; then
echo "error.. need args"
echo "command: bash $0 <mK, 最大的K值> <nseed, 推荐20> <bed file, 要绝对路径>"
exit 1
fi
nK=$1; nseed=$2; bed=$3; base_dir="`pwd`/admixture"
admixture="/home/software/admixture_linux-1.3.0/admixture"
mkdir -p $base_dir
# 生成20个随机数
for r in $(seq 1 $nseed); 
do 
  curr_dir="${base_dir}/${r}.run"
  mkdir -p $curr_dir && cd $curr_dir
  for K in $(seq 2 $nK); 
  do
    seed=`shuf -i 1-100 -n 1`
    $admixture -s $seed --cv $bed $K -j20 | tee ${curr_dir}/log${K}.out
  done;
done
############# 统计cv
#! /bin/bash
for i in {1..20}; do
grep "CV" ${i}.run/log*.out | awk '{print $3, $4}' | cut -c 4,7-20 > ${i}run.cv_out.txt
done
paste *cv_out.txt > all.cv_out
rm *cv_out.txt
########################################################
