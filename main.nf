#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include { METHYLSEQ } from 'nf-core/methylseq/workflows/methylseq'

workflow {
    METHYLSEQ()
}
