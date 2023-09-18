fa="~/genome-cattle/ARS-UCD1.2/GCF_002263795.1_ARS-UCD1.2_genomic.fna"
gtf="~/genome-cattle/ARS-UCD1.2/GCF_002263795.1_ARS-UCD1.2_genomic.gtf"
################################################
#### 1.CNVcaller检测群体水平CNV
################################################
sawriter="~/software/blasr/alignment/bin/sawritermc"
blasr="~/miniconda3/bin/blasr"
python3="~/miniconda3/bin/python3.9"
### 01.创建Dup link 文件，1000大小
# 1 Split genome into short kmer sequences
$python3 /home/sll/miniconda3/CNVcaller/bin/0.1.Kmer_Generate.py /home/sll/genome-cattle/ARS-UCD1.2/GCF_002263795.1_ARS-UCD1.2_genomic.fna 1000 kmer.fa
# 2 Align the kmer FASTA (from step 1) to reference genome using blasr.
# 1) creat .sa file use sawriter
$sawriter genomic.fa.sa ~/genome-cattle/ARS-UCD1.2/GCF_002263795.1_ARS-UCD1.2_genomic.fna
# 2) blasr 
$blasr kmer.fa $fa --sa genomic.fa.sa --out kmer.aln -m 5 --noSplitSubreads --minMatch 15 --maxMatch 20 --advanceHalf --advanceExactMatches 10 --fastMaxInterval --fastSDP --aggressiveIntervalCut --bestn 10
# 3 Generate duplicated window record file
$python3 /home/sll/miniconda3/CNVcaller/bin/0.2.Kmer_Link.py kmer.aln 1000 ARS_UCD1.2_1000
################################################
### 02.计算所有个体绝对拷贝数
# 1) Create a window file for the genome (you can use it directly later)
CNVReferenceDB="/home/sll/miniconda3/CNVcaller/bin/CNVReferenceDB.pl"
perl $CNVReferenceDB $fa -w 1000

# 2) Calculate the absolute copy number  of each window
IndividualProcess="/home/sll/miniconda3/CNVcaller/Individual.Process.sh"
Winlink="/home/sll/genome-cattle/CNVCaller-Duplink/ARS_UCD1.2_1000_link"
sample_list="sample_list.txt"  #per row per ID
cat $sample_list | while read -r sample;
do
    echo $sample
    bash $IndividualProcess -b `pwd`/${sample}.sorted.addhead.markdup.bam -h $sample -d $Winlink -s none;
done
################################################
CNVDis="/home/sll/miniconda3/CNVcaller/CNV.Discovery.sh"
### 03.定义CNV边界
touch exclude_list
bash $CNVDis -l `pwd`/wagyu_angus_hostein.txt -e `pwd`/exclude_list -f 0.1 -h 3 -r 0.5 -p 03.wagyu_angus_hostein.primaryCNVR -m 03.wagyu_angus_hostein.mergeCNVR
################################################
### 04.确定基因型
python /home/sll/miniconda3/CNVcaller/Genotype.py --cnvfile 03.wagyu_angus_hostein.mergeCNVR --outprefix 04.wagyu_angus_hostein.genotypeCNVR --nproc 24
################################################
GetSVtype="~/script/CNVCaller/GetSVtypeForIntersect.py"
# 05.提取SVTYPE及位置信息
python $GetSVtype --vcffile 04.wagyu_angus_hostein.genotypeCNVR.vcf --out 05.wagyu_angus_hostein.genotypeCNVR_getsv.vcf
################################################
#### 2.smoove (LUMPY) 检群体水平SV
################################################
### 需要bam文件的.bam.bai索引文件
samtools index input.bam
### 01.对每个个体进行call SV
smoove="~/software/smoove"
sample_list="sample_list.txt"  # per row per ID，文件最后一行记得留换行符，否则会漏掉最后一个ID
fa=~/genome-cattle/ARS-UCD1.2/GCF_002263795.1_ARS-UCD1.2_genomic.fna
cat $sample_list | while read -r sample;
do
    echo $sample
    $smoove call --outdir results-smoove/ --name $sample --fasta $fa -p 1 --genotype ${sample}.sorted.addhead.markdup.bam;
done
################################################
### 02.合并所有个体的联合位点
$smoove merge --name 02.wagyu_angus_hostein.merged -f $fa --outdir ./ /home/sll/2023-CNV/02_Smoove_result/01.wagyu_results-smoove/*.genotyped.vcf.gz /home/sll/2023-CNV/02_Smoove_result/01.angus_results-smoove/*.genotyped.vcf.gz /home/sll/2023-CNV/02_Smoove_result/01.hostein_results-smoove/*.genotyped.vcf.gz
################################################
### 03.对这些为位点的每个个体call genetype
smoove="/home/sll/software/smoove"
sample_list="/home/sll/20230629-cattle-bam/hn/wagyu.txt"
reference="/home/sll/genome-cattle/ARS-UCD1.2/GCF_002263795.1_ARS-UCD1.2_genomic.fna"
cat $sample_list | while read -r sample;
do
    echo "$sample"
    $smoove genotype -d -x -p 1 --name ${sample}-joint --outdir 03.wagyu_angus_hostein-results-genotped/ --fasta $reference --vcf 02.wagyu_angus_hostein.merged.sites.vcf.gz /home/sll/20230629-cattle-bam/hn/${sample}.sorted.addhead.markdup.bam;
done
################################################
### 04.合并所有个体VCF
$smoove paste --name 04.wagyu_angus_hostein-cohort /home/sll/2023-CNV/02_Smoove_result/03.wagyu_angus_hostein-results-genotped/*.vcf.gz
################################################
### 05提取smoove后的svtyp的位置
GetSVtype="~/script/smoove/05.GetCnvrFromSmooveResult.py"
python $GetSVtype --vcffile 04.wagyu_angus_hostein-cohort.smoove.square.vcf.gz --outfile 05.wagyu_angus_hostein-smoove_svpos.txt
################################################
### 只保留30个染色体 
replacechr="~/script/replace_chr/ReplaceChr.py"
python $replacechr -i 05.wagyu_angus_hostein-smoove_svpos.txt -c ~/script/replace_chr/chr2-NC.txt -o 05.wagyu_angus_hostein-smoove_svpos_30chr.txt
################################################
### smoove结果对CNVcaller结果进行矫正
## 06 提取DUP和EDL
grep "<DEL>" 05.wagyu_angus_hostein.genotypeCNVR_getsv_30chr.vcf > 06.wagyu_angus_hostein-CNVcaller_30chr_DEL.txt
grep "<DUP>" 05.wagyu_angus_hostein.genotypeCNVR_getsv_30chr.vcf > 06.wagyu_angus_hostein-CNVcaller_30chr_DUP.txt
grep "<DEL>" 05.wagyu_angus_hostein-smoove_svpos_30chr.txt > 06.wagyu_angus_hostein-smoove_30chr_DEL.txt
################################################
只对DEL类型的进行矫正，DUP类型的降低假阳性即可
## 也就是用bedtools取交集，交集相互重叠率（reciprocal ratio）超过30%且为同一类CNV，则认为是同一个CNVR
## -f 0.3 -r联用表示取相互重叠率
## -f 0.3 -F 0.3 -e联用为任意文件重叠率
## -wa保留重叠结果中CNVcaller的完整区间，方便下一步分析
bedtools intersect -f 0.30 -F 0.3 -e -a 06.wagyu_angus_hostein-CNVcaller_30chr_DEL.txt -b 06.wagyu_angus_hostein-smoove_30chr_DEL.txt -wa > wagyu_angus_hostein-CNVcaller_smoove-DEL

# Del-overlap_interval.py去除结果中的重叠区间
Deloverlap="~/script/Del-overlap_interval.py"
python $Deloverlap -i wagyu_angus_hostein-CNVcaller_smoove-DEL -o wagyu_angus_hostein-CNVcaller_smoove-nonoverlap_DEL
################################################
### 07 合并DUP与矫正后的DEL
cat wagyu_angus_hostein-CNVcaller_smoove-nonoverlap_DEL 06.wagyu_angus_hostein-CNVcaller_30chr_DUP.txt > 07.wagyu_angus_hostein-CNVcaller_smoove_30chr_CNV
### 提取前三列位置并手动加头文件chr start end
awk '{print $1"\t"$2"\t"$3}' 07.wagyu_angus_hostein-CNVcaller_smoove_30chr_CNV > 07.wagyu_angus_hostein-CNVcaller_smoove_30chr_CNV.pos
################################################
### 08 GetCleanCNV.py脚本提取位置对应的genotypeCNVR.tsv文件内容
GetCNV="~/script/CNVCaller/GetCleanCNV.py"
## 记得给genotypeCNVR.tsv换染色体，且把头文件补上
mkdir 08.correct_CNV
python $GetCNV --cnvr ./01_CNVcaller_RD_normalized/04.wagyu_angus_hostein_30chr.genotypeCNVR.tsv --clean 07.wagyu_angus_hostein-CNVcaller_smoove_30chr_CNV.pos --out 08.correct_CNV/08.wagyu_angus_hostein-CNVcaller_smoove_30chr_CNV2filter
################################################
cd 08.correct_CNV
#### 进行过滤，降低假阳性
CNVfilter="~/script/CNVCaller/New_cnvFilterAfterCNVcaller.py"
python $CNVfilter -f 08.wagyu_angus_hostein-CNVcaller_smoove_30chr_CNV2filter.txt -o 09.wagyu_angus_hostein-CNVcaller_smoove_30chr
################################################
开始正式分析
#### RectChr绘制CNV图谱
cd RectChr
~/software/RectChr/bin/RectChr -InConfi in.cofi -OutPut OUT

#### annavor对整个CNV数据集进行基因注释
python ~/script/replace_chr/ReplaceChr.py -i 08.wagyu_angus_hostein-CNVcaller_smoove_30chr_CNV2filter.txt -c /home/sll/script/replace_chr/chr2-NC.txt -o 08.wagyu_angus_hostein-CNVcaller_smoove_30chr_CNV2filter.NC.txt

python ~/miniconda3/CNVcaller/CNVcaller_tools/cnvcallertools/main.py annannovar --cnvfile 08.wagyu_angus_hostein-CNVcaller_smoove_30chr_CNV2filter.NC.txt --outprefix anno.genotypeCNVR.vcf --annovar /home/sll/software/annovar/annotate_variation.pl --buildver cattle1.2 --buildpath /home/sll/software/annovar/Bos
#### PCA
# ~/2023-CNV/08.correct_CNV/pca
# VCFTOOLS提取过滤后vcf文件，vcftools转成plink，再转成二进制格式，GCTA做
# dup del both都是一下操作
vcftools --vcf ~/2023-CNV/01_CNVcaller_RD_normalized/04.wagyu_angus_hostein.genotypeCNVR.vcf --positions dup.NC.pos --recode --out dup

python ~/script/replace_chr/ReplaceChr.py -i dup.recode.vcf -c ~/script/replace_chr/chr2-NC.txt -o dup.recode.30chr.vcf
vcftools --vcf dup.recode.30chr.vcf --plink --out dup
plink --allow-extra-chr --chr-set 30 --file dup --make-bed --out dup

/home/software/gcta_1.92.3beta3/gcta64 --bfile dup --make-grm --autosome-num 29 --out dup.gcta
/home/software/gcta_1.92.3beta3/gcta64 --grm dup.gcta --pca 10 --out dup.gcta.out
#### 计算VST
## GetCleanCNV.py从mergeCNVR中获得最终的CNVR
先给mergeCNVR文件换染色体
python ~/script/replace_chr/ReplaceChr.py -i 03.wagyu_angus_hostein.mergeCNVR -c ~/script/replace_chr/chr2-NC.txt -o 03.wagyu_angus_hostein-30chr.mergeCNVR
把头文件手动加上

python ~/script/CNVCaller/GetCleanCNV.py --cnvr ~/2023-CNV/01_CNVcaller_RD_normalized/03.wagyu_angus_hostein-30chr.mergeCNVR --clean 09.wagyu_angus_hostein-CNVcaller_smoove_30chr.Get_Region.txt --out 10.wagyu_angus_hostein-CNVcaller_smoove_30chr.CNVR

## calVstAfterCNVcaller.py计算VST
python ~/script/CNVCaller/calVstAfterCNVcaller.py --file 10.wagyu_angus_hostein-CNVcaller_smoove_30chr.CNVR --p1 angus_hostein.txt --p2 wagyu.txt --out wagyu-angus_hostein.vst

wagyu-angus_hostein.vst.Vst.txt将<0的改为0，画图，取>= 0.5的为群体间高度分化的Vst值对应的CNVR

# 对>=0.5的注释
python ~/script/replace_chr/ReplaceChr.py -i wagyu-angus_hostein.vst_0.5.txt -c /home/sll/script/replace_chr/chr2-NC.txt -o wagyu-angus_hostein.vst_0.5.NC.txt



