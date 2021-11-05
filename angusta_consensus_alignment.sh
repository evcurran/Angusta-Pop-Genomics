#!/bin/bash
#$ -l h_rt=100:00:00
#$ -l mem=16G
#$ -l rmem=16G
#$ -m bea
#$ -M e.v.curran@sheffield.ac.uk
#$ -j y

source $HOME/.bash_profile

### Adapted from script by J.K. Olofsson in Olofsson et. al. 2016 (doi: 10.1111/mec.13914)

BAM=/shared/christin_lab1/shared/Emma/BAMs/wgs 

# SAMPLEID.bam - list of input bam files (nuclear or chloroplast)

SAMPLES=nuclear_bams.txt

BED=Step_2.txt

REF=/shared/christin_lab1/genome_data/Assemberlies/REFERENCE/Dovetail/alloteropsis_semialata_final_assembly/ASEM_C4_v1.0.fasta

countBases2=/shared/christin_lab1/shared/scripts/Genome_skimming_to_gene_alignments/countBases2.py

REMOVEN=/shared/christin_lab1/shared/scripts/Genome_skimming_to_gene_alignments/Remove_N_OnlySeqs.py

HCOV=hcov.txt
RSEQ=rseq.txt


# step 1
#awk '{OFS="\t"; if (!/^#/){print $1,$2-1,$2,$4"/"$5,"+"}}' Step_1.txt > Step_2.txt
#rm Step_1.txt

# step 2
# cat $SAMPLES | while read line ; do samtools mpileup -q 20 -A -l Step_2.txt -f ${REF} ${BAM}/${line}_nuclear.sorted.bam  >  ${line}.mpileup; done
#
# # step 3
# # filter for depth in RSEQ and HCOV data (NOT FOR GSKM)
# cat $HCOV | while read line ; do awk '(NR>1) && ($4 > 9 ) ' "$line".mpileup > "$line".mpileup.mod ; done
# cat $HCOV | while read line ; do mv "$line".mpileup.mod "$line".mpileup ; done
# cat $RSEQ | while read line ; do awk '(NR>1) && ($4 > 3 ) ' "$line".mpileup > "$line".mpileup.mod ; done
# cat $RSEQ | while read line ; do mv "$line".mpileup.mod "$line".mpileup ; done
#
#
#
# # step 4
# cat ${SAMPLES} | while read line ; do awk 'BEGIN{OFS="\t"}; {print $1":"$2, $0}' "$line".mpileup > "$line".mpileup.1 ; done
# awk '{print $1":"$3, $1,$3,$4,$5}' Step_2.txt | sed 's/ /\t/g'  > SNP.bed.2
# cat ${SAMPLES} | while read line ; do awk 'NR==FNR{a[$1]=$0 ; next}  {{ found=0; for(i=1;i<=NF;i++) { if($i in a) { print a[$i]; found=1; break; } } if (!found) {print $0} } }' "$line".mpileup.1 SNP.bed.2  > "$line".mpileup.2 ; done
#
# # step 5
# cat ${SAMPLES} | while read line ; do awk 'BEGIN {OFS="\t"}; { if ($5=="+" ) $5="0"; print $2,$3,$4,$5,$6,$7 }' "$line".mpileup.2 |sed 's/ /\t/g' |   sed 's/\/\A,C,G//g' | sed 's/\/\A,G,C//g' | sed 's/\/\A,C,T//g' | sed 's/\/\A,T,C//g' | sed 's/\/\A,G,T//g' | sed 's/\/\A,T,G//g' | sed 's/\/\C,A,G//g' | sed 's/\/\C,G,A//g' | sed 's/\/\C,A,T//g' | sed 's/\/\C,T,A//g' | sed 's/\/\C,G,T//g' | sed 's/\/\C,T,G//g' | sed 's/\/\G,A,C//g' | sed 's/\/\G,C,A//g' | sed 's/\/\G,A,T//g' | sed 's/\/\G,T,A//g' | sed 's/\/\G,C,T//g' | sed 's/\/\G,T,C//g' | sed 's/\/\T,A,C//g' | sed 's/\/\T,C,A//g' | sed 's/\/\T,A,G//g' | sed 's/\/\T,G,A//g' | sed 's/\/\T,C,G//g' | sed 's/\/\T,G,C//g' | sed 's/\/\A,C//g' | sed 's/\/\C,A//g' | sed 's/\/\A,G//g' | sed 's/\/\G,A//g' | sed 's/\/\A,T//g' | sed 's/\/\T,A//g' | sed 's/\/\C,G//g' | sed 's/\/\G,C//g' | sed 's/\/\C,T//g' | sed 's/\/\T,C//g' | sed 's/\/\G,T//g' | sed 's/\/\T,G//g'  | sed 's/\/\A//g'  | sed 's/\/\C//g' | sed 's/\/\G//g' | sed 's/\/\T//g' > "$line".mpileup.3 ; done
#
# # step 6
# cat ${SAMPLES} | while read line ; do awk '{gsub("/","A",$3)}1' "$line".mpileup.3 |  awk '{gsub("+","0",$4)}1' |  awk '{gsub("N","A",$3)}1' | sed 's/ /\t/g'   > "$line".mpileup.4 ; done
# cat ${SAMPLES} | while read line ; do python ${countBases2} "$line".mpileup.4 > "$line".count ; done
#
# # step 7
# # remove bases supported by less than 3 reads"  (NOT GSKM)
#
# cat $HCOV  | while read line ; do cat "$line".count | awk 'BEGIN { OFS="\t" ; } ; { if ($5 <3) $5 = "0" ; else $5 = $5; } ; 1' | awk 'BEGIN { OFS="\t" ; } ; { if ($6 <3) $6 = "0" ; else $6 = $6; } ; 1' | awk 'BEGIN { OFS="\t" ; } ; { if ($7 <3) $7 = "0" ; else $7 = $7; } ; 1' | awk 'BEGIN { OFS="\t" ; } ; { if ($8 <3) $8 = "0" ; else $8 = $8; } ; 1' > "$line".count.mod ; done
# cat $HCOV  | while read line ; do mv "$line".count.mod "$line".count ; done
#
# cat $RSEQ  | while read line ; do cat "$line".count | awk 'BEGIN { OFS="\t" ; } ; { if ($5 <3) $5 = "0" ; else $5 = $5; } ; 1' | awk 'BEGIN { OFS="\t" ; } ; {$
# cat $RSEQ  | while read line ; do mv "$line".count.mod "$line".count ; done
#


# step 8
cat ${SAMPLES} | while read line ; do awk -F "\t" 'BEGIN{OFS="\t"};{print $0, $5+$6+$7+$8+$9+$10}' "$line".count | awk 'BEGIN {OFS="\t"};{max=0;for(i=5;i<9;i++)if($i!~/NA/&&$i>max){max=$i;}; maxfreq=0; if($13==0) maxfreq="-nan" ; else maxfreq=max/$13 ; print $0, maxfreq}' | awk 'BEGIN{OFS="\t"}; { if($14=="-nan" ) $14="0"; print $0}' | awk 'BEGIN{OFS="\t"} {j=sprintf("%8.2f", $14); print $0, j}' | awk 'BEGIN{OFS="\t"}; {a=0; if($13==0) a=0 ; else a=sprintf("%8.2f",$5/$13);print $0, a}' | awk 'BEGIN{OFS="\t"}; {c=0; if($13==0) c=0 ; else c=sprintf("%8.2f",$6/$13);print $0, c}' | awk 'BEGIN{OFS="\t"}; {g=0; if($13==0) g=0 ; else g=sprintf("%8.2f",$7/$13);print $0, g}' | awk 'BEGIN{OFS="\t"}; {t=0; if($13==0) t=0 ; else t=sprintf("%8.2f",$8/$13);print $0, t}' | awk -v col=A 'BEGIN{OFS="\t"}; {NT=""; if($15==$16){NT=col}else{NT="-";}; print $0, NT}' | awk -v col=C 'BEGIN{OFS="\t"}; {NT=""; if($15==$17){NT=col}else{NT="-";}; print $0, NT}' | awk -v col=G 'BEGIN{OFS="\t"}; {NT=""; if($15==$18){NT=col}else{NT="-";}; print $0, NT}' | awk -v col=T 'BEGIN{OFS="\t"}; {NT=""; if($15==$19){NT=col}else{NT="-";}; print $0, NT}'  | awk 'BEGIN{OFS="\t"}; {print $1,$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $20$21$22$23}' | awk 'BEGIN {OFS="\t"};{if($15=="----")$15="N";print $0}' | awk 'BEGIN {OFS="\t"};{gsub("-","",$15); print $0}' > "$line".count.2 ; done


# step 9
cat ${SAMPLES} | while read line ; do awk -v col5=A 'BEGIN {OFS="\t"};{GTA="";if($5!=0){GTA=col5;}else{GTA="-";}print $0,GTA}' "$line".count.2 | awk -v col6=C 'BEGIN {OFS="\t"};{GTC="";if($6!=0){GTC=col6;}else{GTC="-";}print $0,GTC}'| awk -v col7=G 'BEGIN {OFS="\t"};{GTG="";if($7!=0){GTG=col7;}else{GTG="-";}print $0,GTG}' | awk -v col8=T 'BEGIN {OFS="\t"};{GTT="";if($8!=0){GTT=col8;}else{GTT="-";}print $0,GTT}' | awk 'BEGIN {OFS="\t"};{print$0, $16$17$18$19}'| awk 'BEGIN {OFS="\t"};{if($20=="----")$20="N";print $0}'|awk 'BEGIN {OFS="\t"};{gsub("-","",$20); print $0}' | awk 'BEGIN{OFS="\t"}; {print $1,$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $20}' | awk 'BEGIN {OFS="\t"}; {if($14>0.9 && length($16)>=2) $16=$15; print $0}' | awk 'BEGIN {OFS="\t"}; {if($4>100000000000)$16="N"; print $0}' | awk 'BEGIN {OFS="\t"};{ if(length($16)>=3)$16="N";print$0 }' > "$line".count.3 ; done

# step 10
cat ${SAMPLES} | while read line ; do awk -v sample="$line" 'BEGIN{OFS="\t"}; {print sample, $1":"$2, $16}' "$line".count.3 > "$line".count.4 ; done

# step 11
cat ${SAMPLES} | while read line ; do  awk 'BEGIN{OFS="\t"}; {GT2==""; if($3=="A"){GT2="AA";}else{GT2="-"} print $0, GT2}' "$line".count.4 | awk 'BEGIN{OFS="\t"}; {if($3=="C"){$4="CC";} print $0}' | awk 'BEGIN{OFS="\t"}; {if($3=="G"){$4="GG";} print $0}' | awk 'BEGIN{OFS="\t"}; {if($3=="T"){$4="TT";} print $0}' | awk 'BEGIN{OFS="\t"}; {if($3=="AC"){$4=$3;} print $0}' | awk 'BEGIN{OFS="\t"}; {if($3=="AG"){$4=$3;} print $0}' | awk 'BEGIN{OFS="\t"}; {if($3=="AT"){$4=$3;} print $0}' | awk 'BEGIN{OFS="\t"}; {if($3=="CG"){$4=$3;} print $0}' | awk 'BEGIN{OFS="\t"}; {if($3=="CT"){$4=$3;} print $0}' | awk 'BEGIN{OFS="\t"}; {if($3=="GT"){$4=$3;} print $0}' | awk 'BEGIN{OFS="\t"}; {if($3=="N"){$4="NA";} print $1, $2, $4}' > "$line".count.5 ; done

# step 12
cat ${SAMPLES} | while read line ; do cat "$line".count.5  | sed 's/"//g' | sed 's/NA/N/g' | sed 's/AC/M/g' | sed 's/AG/R/g' | sed 's/AT/W/g' | sed 's/CG/S/g' | sed 's/CT/Y/g' | sed 's/GT/K/g' | sed 's/AA/A/g' |sed 's/CC/C/g' |sed 's/GG/G/g' | sed 's/TT/T/g' | sed 's/.bam/\n/g' | sed 's/The/>The/g' > "$line".vertical.fasta  ; done

# step 13
cat ${SAMPLES} | while read line; do echo "$line"; cut -f 3 "$line".vertical.fasta | awk 'BEGIN { ORS = "" } { print }' | sed '$a\' | sed "s/^/>"$line"__nuclear\n/g" > consensus_"$line"_plastome.fasta; done
