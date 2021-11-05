#!/bin/bash
#$ -l h_rt=48:00:00
#$ -l mem=16G
#$ -l rmem=16G
#$ -m bea
#$ -M e.v.curran@sheffield.ac.uk
#$ -j y

# File with 2 columns, barcode and sample ID
barcodes="plate13_barcodes.csv"

# input and output directories
input_dir="/mnt/fastdata-sharc/bo1evc/raw_reads/angusta/Sample_GBS_Pool13"
output_dir="/mnt/fastdata-sharc/bo1evc/raw_reads/angusta/Sample_GBS_Pool13/demultiplexed"


process_radtags -1 $input_dir/lane2_Undetermined_L002_R1_001_pool13_paired.fq.gz -2 $input_dir/lane2_Undetermined_L002_R2_001_pool13_paired.fq.gz -i gzfastq -b $barcodes -o $output_dir --inline_null -e ecoRI -r -c -q
