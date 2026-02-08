FROM rocker/tidyverse:4.3.3

ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && \
    apt-get install -qq -y --no-install-recommends \
    build-essential wget less vim procps \
    libssl-dev libxml2-dev libcurl4-openssl-dev librsvg2-dev r-cran-v8 \
    libbz2-dev liblzma-dev gfortran \
    libpng-dev libjpeg-dev libtiff-dev libfreetype6-dev \
    python3-dev python3-pip python3-setuptools openjdk-21-jre-headless \
    bowtie2 fastqc samtools trim-galore picard-tools && \
    pip3 install --no-cache-dir https://files.pythonhosted.org/packages/c1/fe/c557e1170f831876c8673c067c5258326312e6e34b22c228f3e5d72857be/macs3-3.0.3.tar.gz deeptools && \
    R -e 'install.packages("BiocManager", repos="http://cran.rstudio.com/")' && \
    R -e 'BiocManager::install(c("DiffBind", "DESeq2", "edgeR", "ChIPseeker", "clusterProfiler", "TxDb.Hsapiens.UCSC.hg38.knownGene", "org.Hs.eg.db"), ask=FALSE, Ncpus=parallel::detectCores())' && \
    echo '#!/bin/bash\njava -jar /usr/share/java/picard.jar "$@"' > /usr/local/bin/picard && \
    chmod +x /usr/local/bin/picard && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home