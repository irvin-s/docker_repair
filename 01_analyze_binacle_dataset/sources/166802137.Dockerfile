FROM ubuntu:xenial
MAINTAINER ttickle@broadinstitute.org

######################
## Environment
######################

## Constants
### SOFTWARE versions
ENV R_VERSION 3.3.1-1xenial0

### locations
ENV BIN /usr/local/bin
ENV R_DATA /usr/local/R/data
ENV R_STUDIO /usr/local/R
ENV SRC /usr/local/src

######################
## Dependencies and Tools
######################
##############
## Helper tools
RUN apt-get update && \
    apt-get install -y unzip wget git

##############
## System tools
## devtools: libssl-dev, libcurl4-openssl-dev, libxml2-dev
## rstudio: libjpeg62, libgstreamer0.10-0, libgstreamer-plugins-base0.10-0
RUN apt-get install -y libssl-dev libcurl4-openssl-dev libxml2-dev libxt-dev libgstreamer0.10-0 libjpeg62 ibgstreamer-plugins-base0.10-0

##############
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | tee -a /etc/apt/sources.list && \
    gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 && \
    gpg -a --export E084DAB9 | apt-key add - && \
    apt-get update && \ 
    apt-get install -y r-recommended=${R_VERSION} && \
    apt-get install -y r-base=${R_VERSION}
#    apt-get install -y r-base-dev=${R_VERSION}

##############
## devtools
## seurat
RUN echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"devtools\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    echo "biocLite(\"RcppArmadillo\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    echo "biocLite(\"reshape\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    echo "biocLite(\"Rook\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    echo "biocLite(\"rjson\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    echo "biocLite(\"RMTstat\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    echo "biocLite(\"extRemes\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    echo "biocLite(\"pcaMethods\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    echo "biocLite(\"SummarizedExperiment\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    echo "biocLite(\"pheatmap\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    echo "biocLite(\"amap\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    echo "biocLite(\"useful\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    echo "biocLite(\"vioplot\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    echo "biocLite()" >> ${SRC}/install_pkgs.R && \
    echo "devtools::install_github(\"satijalab/seurat\")" >> ${SRC}/install_pkgs.R && \
    echo "devtools::install_github(\"RGLab/MAST@summarizedExpt\")" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

## RStudio
WORKDIR ${R_STUDIO}
RUN wget https://download1.rstudio.org/rstudio-0.99.903-amd64.deb && \
    dpkg -i rstudio-0.99.903-amd64.deb

## Pull in data from ftp
WORKDIR ${R_DATA}
RUN wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/data/bipolar_cluster_seurat.Robj && \
    wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/data/bipolar_raw.Robj && \
    wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/data/bipolar_seurat_pca.Robj && \
    wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/data/mast_zlm.Robj

WORKDIR ${R_STUDIO}/src
RUN wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/src/dotplot.R && \
    wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/src/makeNiceMAST.R

WORKDIR ${R_STUDIO}
RUN wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/cut_and_paste.txt
