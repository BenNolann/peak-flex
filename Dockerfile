# Install Ubuntu as base
FROM rocker/tidyverse

# Install R(4.3.3(latest-ensure this is constant)), Python(3.12), Java(openjdk-21), some bioinf tools
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
apt-get install -y --no-install-recommends build-essential python3-pip python3-setuptools python3-dev wget \
bowtie2 fastqc samtools trim-galore picard-tools


# Install dependencies first
RUN apt-get update -qq && \
    apt-get install -qq -y --no-install-recommends build-essential wget less vim procps \
	libssl-dev libxml2-dev libcurl4-openssl-dev librsvg2-dev r-cran-v8 \
	python3-dev python3-pip python3-setuptools && \
    pip3 install argparse MACS3==3.0.3 deeptools && \
    R -e 'install.packages("BiocManager")' && \
    R -e 'BiocManager::install("csaw")' && \
    R -e 'install.packages("argparse", repo = "https://cloud.r-project.org/")'

# Install DiffBind
RUN R -e "BiocManager::install(c('DiffBind'))"

# Set working directory
WORKDIR /home

