#!/bin/bash
#$ -l h_rt=52:00:00
#$ -l rmem=8G
#$ -l mem=8G
#$ -m bea


pool12="/mnt/fastdata-sharc/bo1evc/raw_reads/angusta/Sample_GBS_Pool13/Sample_lane2"



trimmomatic PE -phred33 ${pool12}/lane2_Undetermined_L002_R1_001.fastq.gz ${pool12}/lane2_Undetermined_L002_R2_001.fastq.gz lane2_Undetermined_L002_R1_001_pool13_paired.fq.gz lane2_Undetermined_L002_R1_001_pool13_unpaired.fq.gz lane2_Undetermined_L002_R2_001_pool13_paired.fq.gz lane2_Undetermined_L002_R2_001_pool13_unpaired.fq.gz ILLUMINACLIP:adaptor_trimmomatic.fa:2:30:10:1:true LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
