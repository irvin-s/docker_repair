FROM ubuntu:15.04
MAINTAINER Peter Belmann

#add data
RUN mkdir /home/biogas
ADD Makefile /home/biogas/Makefile
ADD run.sh /home/biogas/run.sh

#install ray
RUN apt-get update
RUN apt-get install -y wget unzip openssh-server openmpi-bin Ray

#install prodigal
RUN mkdir /opt/bin
RUN wget -O /opt/bin/prodigal https://github.com/hyattpd/Prodigal/releases/download/v2.6.2/prodigal.linux
RUN chmod a+x /opt/bin/prodigal

#install bowtie
RUN apt-get install -y bowtie2

#install samtools
RUN apt-get install -y samtools

#install java (needed for trimmomatic)
RUN apt-get install -y openjdk-7-jre

#install bedtools
RUN apt-get install -y bedtools

#install make
RUN apt-get install make

#set path
ENV PATH /opt/bin:$PATH

WORKDIR /home/biogas
ENTRYPOINT ["/bin/bash","/home/biogas/run.sh"]
