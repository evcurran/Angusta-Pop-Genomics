# Angusta-Pop-Genomics
This repository contains scripts for the population genomics and phylogenomics analyses performed in Curran et al. (2021 - preprint), exploring gene flow dynamics and dispersal history in the grass _Alloteropsis angusta_.

## PCA of anatomical variation
- morpho_pca.R - R script for PCA of anatomical measurements
- pca_morph_data.csv - input data for R script containing anatomical measurements and sample data

## Clean and align WGS reads
- wgs_read_cleaning.sh - Quality assessment of fastq files, trimming of adaptors and low quality bases.
- align_to_ref.sh - Align cleaned reads to reference sequence (used for WGS and RAD data).
- post_process_sams.py - process sam files: convert to bam, sort, keep only uniquely aligned reads in proper pairs.

## Phylogenetic tree
- angusta_consensus_alignment.sh - Produce a phylip file from bam files, for input into RAxML.
- raxml_nuc_tree.sh - Build a phylogenetic tree from nuclear or chloroplast alignments.

## Isolation-by-distance 
- angusta_ibd.r - R script with permutation tests to test the relationship between pairwise geographic and genetic distances
- pairwise_fst_geo_ibd.csv - Pairwise Fst and geographic distances between populations 
