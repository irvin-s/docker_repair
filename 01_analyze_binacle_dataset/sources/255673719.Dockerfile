FROM buildpack-deps:xenial-scm
MAINTAINER Ivo Buchhalter @ DKFZ

# Install dependencies
RUN \
    apt-get -y update && \
    apt-get -y install \
      build-essential autoconf \
      zlibc zlib1g-dev libncurses5-dev \
      wget unzip \
      python python-matplotlib \
      python-pysam python-numpy python-scipy

ADD scripts/ /usr/local/bin

CMD /usr/local/bin/run_biasfilter.sh -q /home/pcawg/input.vcf /home/pcawg/tumor.bam /home/pcawg/hs37d5.fa
