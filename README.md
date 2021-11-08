# Angusta-Pop-Genomics
This repository contains scripts for the population genomics and phylogenomics analyses performed in [Curran et al. (2021)](https://doi.org/10.1101/2021.04.16.440116), exploring gene flow dynamics and dispersal history in the grass _Alloteropsis angusta_.

## PCA of anatomical variation
- [morpho_pca.R](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/morpho_pca.R) - R script for PCA of anatomical measurements
- [pca_morph_data.csv](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/pca_morph_data.csv) - input data for R script containing anatomical measurements and sample data

## Clean and align WGS reads
- [wgs_read_cleaning.sh](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/wgs_read_cleaning.sh) - Quality assessment of fastq files, trimming of adaptors and low quality bases from ends of reads.
- [align_to_ref.sh](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/align_to_ref.sh) - Align cleaned reads to reference sequence (used for WGS and RAD data).
- [post_process_sams.py](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/post_process_sams.py) - process sam files: convert to bam, sort, keep only uniquely aligned reads in proper pairs.

## Phylogenetic tree
- [angusta_consensus_alignment.sh](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/angusta_consensus_alignment.sh) - Produce a phylip file from bam files, for input into RAxML.
- [raxml_nuc_tree.sh](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/raxml_nuc_tree.sh) - Build a phylogenetic tree from nuclear or chloroplast alignments.

## Processing RAD-seq data
- [trimmomatic.sh](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/trimmomatic.sh) - Remove adaptor and other Illumina-specific sequences and bases with a low quality score from ends of reads.
- [process_radtags_clean.sh](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/process_radtags_clean.sh) - Demultiplex cleaned fastq files using barcodes.

## Population structure
- [gen_beagle.sh](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/gen_beagle.sh) - Generate BEAGLE genotype likelihood file using ANGSD.
- [angusta.beagle.gz](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/angusta.beagle.gz) - BEAGLE genotype likelihood file.
- [ngsadmix.py](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/ngsadmix.py) - Generate shell scripts to run NGSadmix.
- [PCAngsd.sh](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/pcangsd.R) - Carry out PCA on genotype likelihoods using PCAngsd.
- [angusta.cov](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/angusta.cov) - Covariance matrix output by PCAngsd.
- [pcangsd.R](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/pcangsd.R) - Eigenvector decomposition of covariance matrix.

## Isolation-by-distance 
- [alfreq files](https://github.com/evcurran/Angusta-Pop-Genomics/tree/main/alfreq) - Allele frequencies based on RAD-seq sampled populations, calculated following the protocol [here](https://github.com/visoca/popgenomworkshop-hmm).
- [ibd_fst.r](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/ibd_fst.r) - Calculate pairwise Hudson's Fst
- [angusta_ibd.r](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/angusta_ibd.r) - R script with permutation tests to test the relationship between pairwise geographic and genetic distances
- [pairwise_fst_geo_ibd.csv](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/pairwise_fst_geo_ibd.csv) - Pairwise Fst and geographic distances between populations 

## ABBA-BABA
- [abbababa_angsd.sh](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/abbababa_angsd.sh) - Carry out ABBA-BABA tests in ANGSD using bam files as input.
- [bamlist.txt](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/bamlist.txt) - bam files used in this test.
- [abbababa_process_results.R](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/abbababa_process_results.R) - Process and plot ABBA-BABA output
- [angusta_within_abbababa_plot.csv](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/angusta_within_abbababa_plot.csv) - Results of ABBA-BABA tests within A. angusta.
- [ang_sem_bw_abbababa_plot.csv](https://github.com/evcurran/Angusta-Pop-Genomics/blob/main/ang_sem_bw_abbababa_plot.csv) - Results of ABBA-BABA tests between A. angusta and A. semialata.
