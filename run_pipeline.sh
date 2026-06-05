#!/usr/bin/env bash

bash bin/download_data.sh

nextflow run nf-core/methylseq \
    -r 2.6.0 \
    -profile standard \
    -c nextflow.config \
    --input data/samplesheet.csv \
    --outdir results \
    --fasta data/reference/hg38_chr21.fa \
    --emseq

Rscript bin/analyse_methylation.R
