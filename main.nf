#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
 * nf-emseq: Enzymatic Methyl-seq Analysis Pipeline
 */

log.info """
         N F - E M S E Q   P I P E L I N E
         ===================================
         """
         .stripIndent()

// Define the workflow
workflow {
    log.info "Starting nf-emseq pipeline..."
}
