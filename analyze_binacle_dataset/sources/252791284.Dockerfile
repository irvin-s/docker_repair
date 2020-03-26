FROM ubuntu:14.04.3  
MAINTAINER Kapeel Chougule <kchougul@cshl.edu>  
  
LABEL Description "This Dockerfile is used for hisat2 tool"  
  
RUN apt-get update && apt-get install -y \  
build-essential \  
git \  
python \  
samtools  
  
ENV BINPATH /usr/bin  
  
ENV HISAT https://github.com/infphilo/hisat2.git  
  
RUN git clone $HISAT  
  
WORKDIR /hisat2  
  
RUN make && cp hisat2 hisat2-* $BINPATH  
  
ADD Hisat2_align.pl $BINPATH  
  
RUN chmod +x $BINPATH/Hisat2_align.pl  
  
ENTRYPOINT ["/usr/bin/Hisat2_align.pl"]  

