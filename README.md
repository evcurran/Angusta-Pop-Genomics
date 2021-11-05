# Angusta-Pop-Genomics
This repository contains scripts for the population genomics and phylogenomics analyses performed in Curran et al. (2021 - preprint), exploring gene flow dynamics and dispersal history in the grass _Alloteropsis angusta_.

## PCA of anatomical variation
- [morpho_pca.R](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/morpho_pca.R) - R script for PCA of anatomical measurements
- pca_morph_data.csv - input data for R script containing anatomical measurements and sample data

## Clean and align WGS reads
- wgs_read_cleaning.sh - Quality assessment of fastq files, trimming of adaptors and low quality bases from ends of reads.
- align_to_ref.sh - Align cleaned reads to reference sequence (used for WGS and RAD data).
- post_process_sams.py - process sam files: convert to bam, sort, keep only uniquely aligned reads in proper pairs.

## Phylogenetic tree
- angusta_consensus_alignment.sh - Produce a phylip file from bam files, for input into RAxML.
- raxml_nuc_tree.sh - Build a phylogenetic tree from nuclear or chloroplast alignments.

## Processing RAD-seq data
- trimmomatic.sh - Remove adaptor and other Illumina-specific sequences and bases with a low quality score from ends of reads.
- process_radtags_clean.sh - Demultiplex cleaned fastq files using barcodes.

## Population structure
- gen_beagle.sh - Generate BEAGLE genotype likelihood file using ANGSD.
- angusta.beagle.gz - BEAGLE genotype likelihood file.
- ngsadmix.py - Generate shell scripts to run NGSadmix.
- PCAngsd.sh - Carry out PCA on genotype likelihoods using PCAngsd.
- angusta.cov - Covariance matrix output by PCAngsd.
- pcangsd.R - Eigenvector decomposition of covariance matrix.

## Isolation-by-distance 
- [alfreq files](https://github.com/evcurran/Angusta-Pop-Genomics/tree/main/alfreq) - Allele frequencies based on RAD-seq sampled populations, calculated following the protocol [here](https://github.com/visoca/popgenomworkshop-hmm).
- [ibd_fst.r](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/ibd_fst.r) - Calculate pairwise Hudson's Fst
- angusta_ibd.r - R script with permutation tests to test the relationship between pairwise geographic and genetic distances
- pairwise_fst_geo_ibd.csv - Pairwise Fst and geographic distances between populations 
