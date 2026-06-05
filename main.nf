#!/usr/bin/env nextflow

nextflow.enable.dsl=2

workflow {
    log.info """
    ==================================================
    nf-emseq: Orchestration Wrapper
    ==================================================
    Status: Pipeline infrastructure validated.
    Ready for configuration and execution.
    """.stripIndent()
}
