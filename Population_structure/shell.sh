~/20230818-sll-vcf/structure
#################### NJtree ##########################
plink  --bfile 159_cattle_snp_geno01_maf005_nchr --allow-extra-chr --chr-set 29  --genome
perl ~/script/MEGA/02_MEGA-meg.pl plink.genome 159_cattle_snp_geno01_maf005_nchr.fam 159_cattle_snp_geno01_maf005_nchr.meg
####################### PCA ##########################
gcta="/home/software/gcta_1.92.3beta3/gcta64"
$gcta --bfile 157_cattle_snp_geno01_maf005-ld502502_nchr.bim --make-grm --autosome-num 29 --out PCA_157_cattle_snp_geno01_maf005-ld502502_nchr.gcta
$gcta --grm PCA_157_cattle_snp_geno01_maf005-ld502502_nchr.gcta --pca 10 --out PCA_157_cattle_snp_geno01_maf005-ld502502_nchr.gcta.out
############# admixture with 20 bootstrap #############
if [ $# -ne 3 ]; then
  echo "error.. need args"
  echo "command: bash $0 <mK, 最大的K值, 默认从2开始> <nseed, 1-100内随机数的数量，推荐20> <bed file, bed文件,要绝对路径>"
  exit 1
fi

nK=$1
nseed=$2
bed=$3
base_dir="`pwd`/admixture"   # 存储输出结果的基本目录

mkdir -p $base_dir
# 生成20个随机数
for r in $(seq 1 $nseed); 
do 
  curr_dir="${base_dir}/${r}.run"
  mkdir -p $curr_dir && cd $curr_dir
  
  for K in $(seq 2 $nK); 
  do
    seed=`shuf -i 1-100 -n 1`
    /home/software/admixture_linux-1.3.0/admixture -s $seed --cv $bed $K -j20 | tee ${curr_dir}/log${K}.out
  done;
done
