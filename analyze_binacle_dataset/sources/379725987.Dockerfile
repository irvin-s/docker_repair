FROM r-base:latest

MAINTAINER Qiang Kou "qkou@umail.iu.edu"

RUN apt-get update && apt-get install -y -t unstable \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev/unstable \
    libxt-dev \
    libssl-dev \
    git \
    libopenblas-dev \
    libfftw3-dev

# Download and install shiny server
RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    R -e "install.packages(c('shiny', 'rmarkdown', 'devtools', 'roxygen2'), repos='https://cran.rstudio.com/')"

# compile mxnet
RUN git clone --recursive https://github.com/dmlc/mxnet/ && cd mxnet && \
    cp make/config.mk . && \
    echo "USE_BLAS=openblas" >>config.mk && \
    echo "USE_OPENCV = 0" >>config.mk && \
    make -j2 && \
    cd R-package && \
    Rscript -e "library(devtools); library(methods); options(repos=c(CRAN='https://cran.rstudio.com')); install_deps(dependencies = TRUE)" && \
    cd .. && \
    make rpkg && \
    R CMD INSTALL mxnet_*.tar.gz

RUN git clone https://github.com/thirdwing/mxnet_shiny.git && \
    cp -r mxnet_shiny/ /srv/shiny-server/

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]
