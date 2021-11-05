#!/bin/bash
#$ -l h_rt=8:00:00
#$ -l mem=8G
#$ -l rmem=8G
#$ -m bea
#$ -M e.v.curran@sheffield.ac.uk
#$ -j y

source activate emmaconda3

# pcansgd.py script from https://github.com/Rosemeis/pcangsd

python pcangsd.py -beagle angusta.beagle.gz -o angusta -admix
