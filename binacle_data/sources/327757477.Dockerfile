# image: diblab/kp-base
FROM ubuntu:14.04
RUN apt-get update && \
    apt-get -y install screen git curl gcc make g++ python-dev unzip \
         default-jre pkg-config libncurses5-dev r-base-core r-cran-gplots \
         python-matplotlib python-pip python-virtualenv sysstat fastqc \
         trimmomatic bowtie samtools blast2 wget
