#!/usr/bin/env Rscript

library(methylKit)
library(ggplot2)

dir.create("results/analysis", recursive = TRUE, showWarnings = FALSE)

meth_files <- list.files("results/bismark/methylation_calls/methylation_coverage", 
                         pattern = "\\.bismark\\.cov\\.gz$", 
                         full.names = TRUE)

if (length(meth_files) == 0) {
    stop("No processing targets found! Check alignment step output configs.")
}

meth_obj <- methRead(as.list(meth_files),
                     sample.id = list("NA12878"),
                     assembly = "hg38",
                     treatment = c(0),
                     context = "CpG")

pdf("results/analysis/methylation_report.pdf", width = 8, height = 6)

#QC
getMethylationStats(meth_obj[[1]], plot = TRUE, both.strands = FALSE)
getCoverageStats(meth_obj[[1]], plot = TRUE, both.strands = FALSE)

dev.off()
