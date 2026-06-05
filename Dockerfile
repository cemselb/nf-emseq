FROM nfcore/base:2.1
LABEL authors="Cemsel Bafligil Suomi" \
      description="Container image for nf-emseq pipeline"

COPY environment.yml /
RUN mamba env create -f /environment.yml && \
    mamba clean -a
    
ENV PATH /opt/conda/envs/nf-emseq/bin:$PATH
