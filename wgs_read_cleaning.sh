#!/bin/bash
#$ -l h_rt=48:00:00
#$ -l mem=16G
#$ -l rmem=16G
#$ -pe openmp 2
#$ -v OMP_NUM_THREADS=2
#$ -m bea
#$ -j y

###### Preprocessing ######
# Make sure all data is in a single directroy named as such IDENTIFIER_R1.fq IDENTIFIER_R2.fq#
# you can have multiple pairs of Fastq files in the directory#

# e.g.:
# ls *.fastq.gz | sed 's/_R[1|2].fastq.gz//g' | sort | uniq  > files.txt

###### Step 1: fastQC of raw data ######

cat files.txt | while read line ; do fastqc "$line"_R1.fastq.gz -t 2 ; fastqc "$line"_R2.fastq.gz -t 2 ; done
rm *.zip
mkdir fastQC_RAW
cat files.txt | while read line ; do mkdir fastQC_RAW/"$line" ; done
cat files.txt | while read line ; do mv "$line"_R1_fastqc.html fastQC_RAW/"$line" ; mv "$line"_R2_fastqc.html fastQC_RAW/"$line" ; done


###### Step 2: NGS QC Toolkit to remove adaptors and remove reads with <80% >q20  ######

IlluQC=/usr/local/extras/Genomics/apps/ngsqcoolkit/current/QC
mkdir IlluQC
cat files.txt | while read line ; do perl ${IlluQC}/IlluQC.pl -pe "$line"_R1.fastq.gz "$line"_R2.fastq.gz 2 A -l 80 -s 20 -o IlluQC/"$line"/ ; done


###### Step 3: NGS QC Toolkit to remove and sequence with ambigious base  ######

AmbiguityFilter=/usr/local/extras/Genomics/apps/ngsqcoolkit/current/Trimming
mkdir AmbiguityFilter
cat files.txt | while read line ; do mkdir AmbiguityFilter/"$line" ; done
cat files.txt | while read line ; do perl ${AmbiguityFilter}/AmbiguityFiltering.pl -i IlluQC/"$line"/"$line"_R1.fastq.gz_filtered -irev IlluQC/"$line"/"$line"_R2.fastq.gz_filtered -c 0 ; done
cat files.txt | while read line ; do mv IlluQC/"$line"/"$line"_R1.fastq.gz_filtered_trimmed AmbiguityFilter/"$line"/  | mv IlluQC/"$line"/"$line"_R2.fastq.gz_filtered_trimmed AmbiguityFilter/"$line"/; done


###### Step 4: NGS QC Toolkit to trim low quality bases (<20) from 3' end of sequence  ######

TrimmingReads=/usr/local/extras/Genomics/apps/ngsqcoolkit/current/Trimming
mkdir TrimmingRead
cat files.txt | while read line ; do mkdir TrimmingRead/"$line" ; done
cat files.txt | while read line ; do perl ${TrimmingReads}/TrimmingReads.pl -i AmbiguityFilter/"$line"/"$line"_R1.fastq.gz_filtered_trimmed -irev AmbiguityFilter/"$line"/"$line"_R2.fastq.gz_filtered_trimmed -q 20 ; done
cat files.txt | while read line ; do mv AmbiguityFilter/"$line"/"$line"_R1.fastq.gz_filtered_trimmed_trimmed TrimmingRead/"$line"/  | mv AmbiguityFilter/"$line"/"$line"_R2.fastq.gz_filtered_trimmed_trimmed TrimmingRead/"$line"/; done


###### Step 5: nxtrim to remove adaptor sequences embedded in the sequnces due to small inserts etc  ######
NXTRIM=/home/bo1evc/software/NxTrim/nxtrim
mkdir nxtrim
cd nxtrim
cat ../files.txt | while read line ; do nxtrim -1 TrimmingRead/"$line"/"$line"_R1.fastq.gz_filtered_trimmed_trimmed -2 TrimmingRead/"$line"/"$line"_R1.fastq.gz_filtered_trimmed_trimmed -O ${line}_nxtrim -rf --separate; done
