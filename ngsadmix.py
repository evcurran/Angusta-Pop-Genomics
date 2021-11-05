import argparse
from random import randint

parser = argparse.ArgumentParser(description="This generates shell scripts for NGSadmix")

parser.add_argument('-i', '--input', help='Path to genotype likelihood file, BEAGLE format', required=True)
parser.add_argument('-o', '--output', help='Path to output directory, then output prefix', required=True)
parser.add_argument('-minK', help='minimum K value', type = int, required = True)
parser.add_argument('-maxK', help='maximum K value', type = int, required = True)
parser.add_argument('-rep', help='Number of repeats for each run', type = int, default = 1)
parser.add_argument('-rmem', help='rmem', default = "4G")
parser.add_argument('-mem', help='mem', default = "8G")
parser.add_argument('-hr', help='time to run on iceberg', default = "8:00:00")
parser.add_argument('-nThreads', help='number of threads to use',  default = "2")
parser.add_argument('-maxiter', help='maximum number of EM iterations',  default = "4000")
parser.add_argument('-tol', help='Tolerance for convergence',  default = "0.0000010")

args = parser.parse_args()
# Generate output prefix based on input options


for i in range(args.minK,args.maxK+1):
    for j in range(1, args.rep+1):
        f = open(args.output + "_K" + str(i) + "_rep" + str(j) + ".sh", "w+")
        f.write("#!/bin/bash" + "\n"
        + "#$ -l h_rt=" + str(args.hr) + "\n"
        + "#$ -l rmem=" + str(args.rmem) + "\n"
        + "#$ -l mem=" + str(args.mem) + "\n"
        + "#$ -m bea" + "\n"
        + "#$ -pe openmp " + str(args.nThreads) + "\n"
        + "\n"
        + "export OMP_NUM_THREADS=" + str(args.nThreads) + "\n"
        + "\n"
        + "/home/bo1evc/software/NGSadmix -likes " + args.input + " -K " + str(i) + " -o " + args.output
        + "_K" + str(i) + "_rep" + str(j) + ".sh" + " -P " + str(args.nThreads) + " -maxiter "
        + str(args.maxiter) + " -tol " + str(args.tol) + " -seed " + str(randint(1,1000000)))
        f.close
