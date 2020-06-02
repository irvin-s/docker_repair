# Docker file for inferCNV
FROM bioconductor/devel_base2

LABEL org.label-schema.license="BSD-3-Clause" \
      org.label-schema.vendor="Broad Institute" \
      maintainer="Christophe Georgescu <cgeorges@broadinstitute.org>"

RUN apt-get update && apt-get -y install curl libssl-dev libcurl4-openssl-dev \
                                        libxml2-dev git python3 jags \
                                        r-cran-rjags && \
                      apt-get clean && rm -rf /var/tmp/* \
                                          /tmp/* /var/lib/apt/lists/*

# Install R and Bioconductor packages
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com'))" >.Rprofile
RUN R -e "install.packages(c('devtools','KernSmooth', 'lattice', 'Matrix', \
                             'survival', 'MASS', 'TH.data', 'nlme', 'ape', \
                             'fitdistrplus', 'multcomp', 'coin', 'binhf', \
                             'caTools', 'coda', 'dplyr', 'doparallel', \
                             'fastcluster', 'foreach', 'futile.logger', \
                             'future', 'gplots', 'ggplot2', 'HiddenMarkov', \
                             'reshape', 'rjags', 'RColorBrew', 'doParallel', \
                             'tidyr', 'gridExtra', 'argparse', 'knitr', \
                             'rmarkdown', 'testthat', 'optparse', 'logging', \
                             'data.table', 'BiocManager'), repos = 'http://cran.us.r-project.org')"
RUN R -e "BiocManager::install(c('BiocGenerics', 'edgeR', 'SingleCellExperiment', \
            'SummarizedExperiment', 'BiocStyle', 'BiocCheck'))"

# Checkout and install infercnv
# update to 2019-05-28 commit (Fix observations heatmap chromosome labels)
RUN git clone https://github.com/broadinstitute/infercnv && cd infercnv && \
      git checkout master && git checkout aeb3a5603fe1de11951307e7205b663141aa04a9 && \
      R CMD INSTALL . 

ENV PATH=${PATH}:/infercnv/scripts

CMD inferCNV.R --help

