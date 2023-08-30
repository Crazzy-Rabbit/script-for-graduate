~/20230818-sll-vcf/structure
#################### NJtree ##########################
plink --bfile 159_cattle_snp_geno01_maf005_nchr --allow-extra-chr --chr-set 29  --genome
perl ~/script/MEGA/02_MEGA-meg.pl plink.genome 159_cattle_snp_geno01_maf005_nchr.fam 159_cattle_snp_geno01_maf005_nchr.meg
#################### MLtree ##########################
iqtree="~/software/iqtree-1.6.12/bin/iqtree"
plink --allow-extra-chr --chr-set 29 --vcf 159_cattle_snp_geno01_maf005.vcf.gz --recode --out 159_cattle_snp_geno01_maf005
python ~/script/ped2fa.py 159_cattle_snp_geno01_maf005.ped 159_cattle_snp_geno01_maf005.fa
$iqtree -s 159_cattle_snp_geno01_maf005.fa -m TEST -st DNA -bb 1000 -nt AUTO

python ~/script/vcf2phylip.py --input 159_cattle_snp_geno01_maf005.vcf.gz --output-prefix 159_cattle_snp_geno01_maf005
raxmlHPC-PTHREADS-SSE3 -f a -m GTRGAMMA -p 23 -x 123 -# 100 -s 159_cattle_snp_geno01_maf005.min4.phy  -o SRR14339798,SRR14416027 -n 159_cattle_snp_geno01_maf005 -T 20
####################### PCA ##########################
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
