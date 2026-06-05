#!/usr/bin/env nextflow

nextflow.enable.dsl=2

log.info """
         ===================================
         nf-emseq: Orchestration Wrapper
         ===================================
         This repository manages the configuration 
         and execution of nf-core/methylseq.
         """.stripIndent()

workflow {
    // This workflow is intentionally empty.
    // The analysis is performed by the nf-core pipeline.
}
