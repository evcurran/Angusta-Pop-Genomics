#!/bin/bash
#$ -l h_rt=168:00:00
#$ -l mem=16G
#$ -l rmem=16G
#$ -j y


raxml=/home/bo1evc/software/standard-RAxML-master/raxmlHPC


$raxml -s consensus_nuclear_ang_sem.phy -n nuc_tree_GTRGAMMA.raxml.out -m GTRCAT -f a -x $RANDOM -# 100 -p $RANDOM
