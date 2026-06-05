#!/usr/bin/env bash
set -euo pipefail

mkdir -p data/raw data/reference

#download human chr 21 as a lightweight reference
if [ ! -f data/reference/hg38_chr21.fa ]; then
    curl -L ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/GRCh38_major_release_seqs/chr21.fa.gz | gunzip > data/reference/hg38_chr21.fa
fi

#download a subset of NA12878 EMseq data
if [ ! -f data/raw/NA12878_1.fastq ]; then
    fasterq-dump SRR19794354 -O data/raw/ --split-files
    
    #downsample to 5M reads to optimise local runtime
    seqtk sample -s100 data/raw/SRR19794354_1.fastq 5000000 > data/raw/NA12878_R1.fastq
    seqtk sample -s100 data/raw/SRR19794354_2.fastq 5000000 > data/raw/NA12878_R2.fastq
    rm data/raw/SRR19794354_*.fastq
fi

#samplesheet for Nextflow
echo "sample,fastq_1,fastq_2,strandedness" > data/samplesheet.csv
echo "NA12878,${PWD}/data/raw/NA12878_R1.fastq,${PWD}/data/raw/NA12878_R2.fastq,auto" >> data/samplesheet.csv
