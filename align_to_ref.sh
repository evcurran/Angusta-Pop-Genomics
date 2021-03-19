#!/bin/bash
#$ -l h_rt=24:00:00
#$ -l mem=16G
#$ -l rmem=16G
#$ -m bea
#$ -j y
#$ -t 1-9   #number of samples


INDEX=$((SGE_TASK_ID-1))

# reference to align to
REF="/shared/christin_lab1/genome_data/Assemberlies/REFERENCE/Dovetail/alloteropsis_semialata_final_assembly"

# directory containing first read pairs
DIR1="/mnt/fastdata-sharc/bo1evc/raw_reads/angusta/Sample_GBS_Pool15/P1"

# directory containing second read pairs
DIR2="/mnt/fastdata-sharc/bo1evc/raw_reads/angusta/Sample_GBS_Pool15/P2"

IN1=($(ls $DIR1/*1.fq.gz))
IN2=($(ls $DIR2/*2.fq.gz))


(bowtie2 -x $REF --no-unal -1 ${IN1[$INDEX]} -2 ${IN2[$INDEX]} -S ${IN1[$INDEX]}_ASEM_C4_v1.sam) 2>${IN1[$INDEX]}.log
