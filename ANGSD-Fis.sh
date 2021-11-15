#!/bin/bash
#$ -l h_rt=96:00:00
#$ -l mem=6G
#$ -l rmem=6G
#$ -pe openmp 4
#$ -v OMP_NUM_THREADS=4
#$ -j y

#####################################################################################
#	Script Name:    ANGSD-Fis.sh
#	Description:    Inbreeding coefficient estimation
#	Author:         LPereira
#	Last updated:   25/10/2021
#####################################################################################

source /usr/local/extras/Genomics/.bashrc

#Directories
out=/mnt/fastdata/bo1lpg/ANGSD-Emma2

cd ${out}

cat 241_id_pops.txt | cut -f 2 | uniq | while read line; do cat 241_id_pops.txt | grep "${line}" | cut -f 1 > ${line}.list ; done
ls | grep ".list" | while read line; do cat ${line} | while read line2; do grep "${line2}" 260_bams.txt >> ${line}2; done ; done

ls ${out} | grep ".list2" | grep -v "inputfiles.list" > inputfiles.list

### Calculate F using HWE test and compute the average F per population across all sites
cat inputfiles.list | while read line; do sample=$(echo ${line} | cut -d '.' -f 1); nsamp=$(wc -l ${line} | cut -d ' ' -f 1); mkdir ${sample}; cd ${sample}; \
  angsd -bam ../${line}  -doHWE 1 -domajorminor 1 -GL 1 -doMaf 1 -SNP_pval 1e-4 -minInd ${nsamp} -P 4; \
  zcat angsdput.hwe.gz | sed 1d | awk -v sam=$sample '{sum+=$7} END { print sam,sum/NR}' >> ../Fis.txt; cd ${out}; done
