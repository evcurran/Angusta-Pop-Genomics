#!/bin/bash
#$ -l h_rt=24:00:00
#$ -l mem=24G
#$ -l rmem=24G
#$ -m bea
#$ -M e.v.curran@sheffield.ac.uk
#$ -j y

source /usr/local/extras/Genomics/.bashrc

bams=bam.list





angsd -bam $bams -GL 2 -doMajorMinor 1 -doMaf 1 -SNP_pval 2e-6 -minMapQ 20 -minQ 20 -minInd 98 -doCounts 1 -setMinDepthInd 5 -doGlf 2 -out angusta -P 1

