FROM biocontainers/biocontainers:debian-stretch-backports
MAINTAINER biocontainers <biodocker@gmail.com>
LABEL    software="bioconductor-gviz" \ 
    container="bioconductor-gviz" \ 
    about.summary="Plotting data and annotation information along genomic coordinates" \ 
    about.home="https://bioconductor.org/packages/Gviz/" \ 
    software.version="1.18.1-1-deb" \ 
    version="1" \ 
    about.copyright=" 2006-2016 Florian Hahne, Steffen Durinck," \ 
    about.license="Artistic-2.0" \ 
    about.license_file="/usr/share/doc/bioconductor-gviz/copyright" \ 
    about.tags=""

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y r-bioc-gviz && apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/*
USER biodocker
