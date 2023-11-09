import gzip

r1 = '/home/sll/2023-CNV-wagyu/08.correct_CNV/fst/CNV.29chr.start.region'
r2 = '/home/sll/2023-CNV-wagyu/08.correct_CNV/fst/CNV.29chr.end.region'
Ld = '61_cattle_geno01_maf005_nchr.snp-cnv.LD.gz'
outfile = 'CNV-SNP50k.LD'

with open (r1,'r') as region1, open (r2,'r') as region2, open (outfile, 'w') as out, gzip.open(Ld,'rb') as ld:
    file_region1 = {(line.split()[0], line.split()[2]) for line in region1}
    file_region2 = {(line.split()[0], line.split()[1]) for line in region2}
    for line in ld:
        if (line.split()[0], line.split()[1]) in file_region1:
            out.write(line)
        if (line.split()[0], line.split()[1]) in file_region2:
            out.write(line)
