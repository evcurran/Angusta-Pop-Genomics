import argparse
from qsub import *
import os

parser = argparse.ArgumentParser(description="This generates and submits shell scripts to convert sam to bam and performs post-processing")

parser.add_argument('-sam', help='Path to folder of SAMs', required=True)
parser.add_argument('-pairs', help='Path to folder to store proper pairs', required=True)
parser.add_argument('-rmem', help='rmem', default = "8")
parser.add_argument('-mem', help='mem', default = "8")
parser.add_argument('-hr', help='time to run on iceberg', default = "8")


args = parser.parse_args()

for SAM in os.listdir(args.sam):
    if SAM.endswith(".sam"):

        # convert to bam and sort
        q_sub(['samtools view -S -b -h ' + args.sam + '/' + SAM + ' | samtools sort > ' + args.sam + '/' + SAM + "_sorted.bam" + '\n'

        # keep only uniquely aligned reads in proper pairs
        'samtools view -h -bq -f2 ' + args.sam + '/' + SAM + "_sorted.bam > "  + args.pairs + '/' + SAM + '_unique.f2.bam' + '\n'

        # sort data by coordinates; save in same folder as proper_pairs
        'samtools sort '  + args.pairs + '/' + SAM + '_unique.f2.bam -o ' + args.pairs + '/' + SAM + '_unique.f2_sort.bam' + '\n'

        # index bam files
        'samtools index ' + args.pairs + '/' + SAM + '_unique.f2_sort.bam'],

        out=str(args.pairs + "/" + SAM),
        t=float(args.hr),
        mem=int(args.mem),
        rmem=int(args.rmem),
        evolgen=False)
