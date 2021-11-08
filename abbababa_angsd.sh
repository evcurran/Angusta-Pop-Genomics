#!/bin/bash
#$ -l h_rt=48:00:00
#$ -l rmem=8G
#$ -l mem=8G
#$ -j y



angsd=/usr/local/extras/Genomics/apps/angsd/current/bin/angsd

$angsd -out abbababa_results -doAbbababa 1 -bam bamlist.txt -doCounts 1 -useLast 1


