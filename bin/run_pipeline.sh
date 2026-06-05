#!/usr/bin/env bash
set -euo pipefail

bash bin/download_data.sh

nextflow run nf-core/methylseq \
    -r 2.6.0 \
    -profile standard \
    -c nextflow.config

Rscript bin/analyse_methylation.R
