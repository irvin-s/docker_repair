####################################################################################
########        This is a Dockerfile to describe QIAGEN's read processing  #########
########        runtime framework for spe-dna panels                       #########
####################################################################################

# Using a biocontainer base image
# Please see below for further details : 
# https://github.com/BioContainers/containers/blob/master/biocontainers/1.1.0/Dockerfile
FROM biocontainers/biocontainers:v1.1.0_cv1

MAINTAINER Raghavendra Padmanabhan <raghavendra.padmanabhan@qiagen.com>

################ Create appropriate directory structure for code to run ################
USER root
RUN mkdir -p /srv/qgen/code && \
    mkdir -p /srv/qgen/bin/downloads

################ Update package repository and install dependencies using apt-get ################
RUN apt-get -y update && \
    apt-get -y install r-base libcurl4-openssl-dev libssl-dev libxml2-dev && \
    apt-get clean && apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

################ Install various version specific 3rd party tools ################
RUN conda install bedtools=2.25.0 htslib=1.3.1 cutadapt=1.10 picard=1.97 snpeff=4.2 bwa=0.7.15
RUN wget https://storage.googleapis.com/qiaseq-dna/lib/ssw.tar.gz \
    https://storage.googleapis.com/qiaseq-dna/lib/fgbio-0.1.4-SNAPSHOT.jar \
    -P /srv/qgen/bin/ && \
    cd /srv/qgen/bin/ && tar -xvf ssw.tar.gz && \
    rm ssw.tar.gz

################ Install python modules ################
## Install some modules with conda
RUN conda install scipy MySQL-python openpyxl pysam=0.9.0
RUN pip install edlib
## Download and install 3rd party libraries
RUN wget https://storage.googleapis.com/qiaseq-dna/lib/py-editdist-0.3.tar.gz \
	https://storage.googleapis.com/qiaseq-dna/lib/sendgrid-v2.2.1.tar.gz \
	https://github.com/weizhongli/cdhit/releases/download/V4.6.8/cd-hit-v4.6.8-2017-1208-source.tar.gz \
	-P /srv/qgen/bin/downloads/ && \
    cd /srv/qgen/bin/downloads/ && tar -xvf py-editdist-0.3.tar.gz && \
    cd py-editdist-0.3 && /opt/conda/bin/python setup.py install && \
    cd /srv/qgen/bin/downloads/ && tar -xvf sendgrid-v2.2.1.tar.gz && \
    cd sendgrid-python-2.2.1 && /opt/conda/bin/python setup.py install && \
    cd /srv/qgen/bin/downloads/ && tar -xvf cd-hit-v4.6.8-2017-1208-source.tar.gz && \
    cd cd-hit-v4.6.8-2017-1208 && make && \
    rm /srv/qgen/bin/downloads/*.tar.gz

## Python 3 and some modules for read-trimmer
RUN apt-get -y update && apt-get -y install software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get -y update && apt-get -y install python3.6 && \
    apt-get -y install python3-pip && \
    apt-get clean && apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip3 install cython edlib

################ R packages ################
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages(c('plyr','tidyverse','magrittr','data.table'))"

################ Update openjdk ################
## note : picard gets updated to match jdk version
RUN conda install -c cyclus java-jdk=8.45.14

################ Add latest samtools version for sort by Tag feature ################
RUN wget https://github.com/samtools/samtools/releases/download/1.5/samtools-1.5.tar.bz2 -O /srv/qgen/bin/downloads/samtools-1.5.tar.bz2 && \
    cd /srv/qgen/bin/downloads/ && \
    tar -xvf samtools-1.5.tar.bz2 && \
    cd samtools-1.5  && \
    mkdir -p /srv/qgen/bin/samtools-1.5 && \
    ./configure --prefix /srv/qgen/bin/samtools-1.5 && \
    make && \
    make install && \
    rm /srv/qgen/bin/downloads/samtools-1.5.tar.bz2

################ Modules for CNV Analysis ################
## Perl
RUN cpan DateTime
RUN cpan DBI
RUN cpan DBD::SQLite
RUN cpan Env::Path
RUN cpan File::chdir
RUN cpan Getopt::Long::Descriptive
RUN cpan Sort:Naturally
RUN cpan Config::IniFiles
RUN cpan Data::Dump::Color
RUN cpan Data::Table::Excel
RUN cpan Hash::Merge
RUN cpan File::Slurp
## R
RUN Rscript -e "install.packages(c('MASS','ggplot2','gridExtra','naturalsort','scales','ggplot2','extrafont'))"

################ TVC binaries ################
RUN mkdir -p /srv/qgen/bin/TorrentSuite/
RUN wget https://storage.googleapis.com/qiaseq-dna/lib/TorrentSuite/tmap \
    https://storage.googleapis.com/qiaseq-dna/lib/TorrentSuite/tvc \
    -P /srv/qgen/bin/TorrentSuite/ && \
    chmod 775 /srv/qgen/bin/TorrentSuite/tmap /srv/qgen/bin/TorrentSuite/tvc
## vcflib
RUN cd /srv/qgen/bin/downloads && git clone --recursive https://github.com/vcflib/vcflib.git && \
    cd vcflib && make && mkdir -p /srv/qgen/bin/vcflib/bin/ && cp bin/* /srv/qgen/bin/vcflib/bin/ && \
    cd / && rm -rf /srv/qgen/downloads/vcflib/

################ Update Environment Variables ################
ENV PYTHONPATH $PYTHONPATH:/opt/conda/lib/python2.7/site-packages/:/srv/qgen/code/qiaseq-dna/
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/srv/qgen/bin/ssw/src/

