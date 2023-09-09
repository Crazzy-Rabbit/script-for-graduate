java -jar ~/software/msms/lib/msms.jar
##################
牛突变率：
u=1.26x10(-8)
Ne=5000
重组率：
1.23cM/Mb
##################
java -jar ~/software/msms/lib/msms.jar -ms 122 1000 -t 6.3 -r 1.23 100000 -I 3 42 40 40 .5 > test
##################################################
-ms 20 1000 样本数 模拟次数
-t  100 突变率*群体有效含量*4
-r  50 20 重组率*2*N 每个中性座位的重组点（可省略）
-I 2 10 10 .25 2亚群 1群数量 2群数量 各亚群间的迁移率
-thread
###################################################

# 若文件少于10行，则删除
awk 'BEGIN{RS="//";ORS="";i=1}{print $0 > "file"i;i++}END{for(j=1;j<i;j++){cmd="grep -v \"^$\" file"j" | wc -l";cmd | getline line;if(line<=10){system("rm file"j)}}}' test
# 所有文件转为vcf格式
ls file* | while read file; do python2.7 ~/software/msms/lib/Ms2Vcf.py $file 122; done

# fst
ls *vcf| while read file; do vcftools --vcf $file --weir-fst-pop ~/20230818-sll-vcf/selection/neutral-simulation/AH.txt --weir-fst-pop ~/20230818-sll-vcf/selection/neutral-simulation/wagyu.txt --fst-window-size 50000 --fst-window-step 25000 --out $file; done
cat *fst | sort -n -k5 > all.fst

# pi
ls *vcf| while read file; do vcftools --vcf $file --window-pi 50000 --window-pi-step 25000 --keep ~/20230818-sll-vcf/selection/neutral-simulation/AH.txt --out ./pi/AH.${file}; done
ls *vcf| while read file; do vcftools --vcf $file --window-pi 50000 --window-pi-step 25000 --keep ~/20230818-sll-vcf/selection/neutral-simulation/wagyu.txt --out ./pi/wagyu.${file}; done
ls *vcf| while read file; do python ~/script/selection/ln_ratio.py --group1 ~/software/msms/lib/file/pi/wagyu.${file}.windowed.pi --group2 ~/software/msms/lib/file/pi/AH.${file}.windowed.pi --nvars 1 --outprefix ~/software/msms/lib/file/pi/wag_AH-${file}.lnratio; done
cat *lnratio.txt | sort -n -k4 > ~/software/msms/lib/all.lnratio

# xpehh
ls *vcf| while read file; do vcftools --vcf $file --plink --out ./xpehh/$file; done
ls *vcf| while read file; do awk 'BEGIN{OFS=" "} {print $1,$2,$4,$4}' ./xpehh/$file.map > ./xpehh/$file.map.distance; done
ls *vcf| while read file; do vcftools --vcf $file --keep ~/20230818-sll-vcf/selection/neutral-simulation/wagyu.txt --recode --recode-INFO-all --out ./xpehh/wagyu.$file; done
ls *vcf| while read file; do vcftools --vcf $file --keep ~/20230818-sll-vcf/selection/neutral-simulation/AH.txt --recode --recode-INFO-all --out ./xpehh/AH.$file; done
ls *vcf| while read file; do /home/software/selscan/bin/linux/selscan --xpehh --vcf ./xpehh/wagyu.$file.recode.vcf --vcf-ref ./xpehh/AH.$file.recode.vcf --map ./xpehh/$file.map.distance --cutoff 0.9 --threads 10 --out  ./xpehh/A_H-Wag.$file; done
ls *vcf| while read file; do /home/software/selscan/bin/linux/norm --xpehh --files ./xpehh/A_H-Wag.$file.xpehh.out --bp-win --winsize 50000; done
ls *vcf| cut -d"e" -f 2 | cut -d"." -f 1 | while read i; do python ~/script/selection/XPEHH_Win_step.py --file ./xpehh/A_H-Wag.file${i}.vcf.xpehh.out.norm --chrosome $i --window 50000 --step 25000; done
mv *XPEHH ./xpehh
cat *XPEHH| sort -n -k4 > /home/sll/software/msms/lib/all.XPEHH
