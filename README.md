# 🧬 nf-emseq: Enzymatic Methyl-seq Analysis Pipeline
[![Nextflow](https://img.shields.io/badge/nextflow-%E2%89%A523.10.1-brightgreen.svg)](https://www.nextflow.io/)
[![nf-core](https://img.shields.io/badge/nf--core-methylseq-81C14B.svg)](https://nf-co.re/methylseq)
[![R](https://img.shields.io/badge/R-4.3.1-276DC3.svg)](https://www.r-project.org/)

A pipeline for **whole genome methylation analysis** using enzymatic methyl-seq (EMseq) data. This repo showcases an end-to-end bioinformatics workflow from raw fastq acquisition to downstream differential methylation analysis using a public human reference dataset (NA12878).

EMseq is utilised here as an alternative to traditional bisulfite sequencing to preserve DNA integrity, yielding higher mapping efficiencies and less GC bias.

## Workflow Overview
```mermaid
flowchart TD
    %% Styling
    classDef process fill:#1768AC,stroke:#333,stroke-width:2px,color:#fff,rx:5px,ry:5px;
    classDef input fill:#f4f4f4,stroke:#666,stroke-width:1px,stroke-dasharray: 5 5;
    classDef output fill:#44A833,stroke:#333,stroke-width:1px,color:#fff;

    %% Nodes
    Input[("☁️ Public EM-seq Data<br/>(SRA Accession)")]
    FETCH["FETCH_DATA<br/>Download & downsample (seqtk)"]
    PREPROCESS["RUN_NF_CORE<br/>QC, Trim Galore! & Alignment"]
    CALLING["CALL_METHYLATION<br/>Bismark / MethylDackel"]
    
    %% Downstream
    ANALYSE["ANALYSE_METHYLATION<br/>Global stats & CpG metrics (methylKit)"]

    %% Output Nodes
    OutQC[\"📊 MultiQC Report<br/>Aligned BAMs"/]
    OutStats[\"📈 Methylation Stats PDF<br/>CpG Coverage Reports"/]

    %% Connections
    Input --> FETCH
    FETCH -->|FastQ pairs| PREPROCESS
    PREPROCESS -->|Filtered BAMs| CALLING
    
    %% Forking outputs
    PREPROCESS --> OutQC
    CALLING -->|bedGraph / cov| ANALYSE
    ANALYSE --> OutStats

    %% Apply Classes Safely
    class Input input;
    class FETCH,PREPROCESS,CALLING,ANALYSE process;
    class OutQC,OutStats output;
```

1. **Data Acquisition**: Download and downsampling of NA12878 EM-seq data (SRX16351685).
2. **Core Pipeline**: Execution via `nf-core/methylseq` configured specifically for EMseq characteristics.
    * Quality control (`FastQC`, `MultiQC`)
    * Adapter trimming (`Trim Galore!`)
    * Alignment and methylation calling (`Bismark` & `MethylDackel`)
3. **Downstream Analysis**: R-based characterisation of global methylation patterns and CpG coverage.

## Repo structure
```
nf-emseq/
├── README.md
├── nextflow.config
├── run_pipeline.sh
├── bin/
│   ├── download_data.sh
│   └── analyse_methylation.R
└── envs/
    └── environment.yml
```

## Getting Started

### Prerequisites

Ensure you have Conda/Mamba and Nextflow installed. Clone the repository and activate the environment:

```bash
git clone [https://github.com/cemselb/nf-emseq.git](https://github.com/cemselb/nf-emseq.git)
cd nf-emseq
mamba env create -f envs/environment.yml
conda activate nf-emseq
```
