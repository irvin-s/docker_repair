FROM ubuntu:12.10  
RUN apt-get update  
RUN apt-get -y install curl git vim man make  
RUN apt-get -y install software-properties-common python-software-properties  
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu precise universe"  
RUN apt-get update  
RUN apt-get -y install unpaper imagemagick xpdf-utils  
  
WORKDIR /src  
CMD ["make", "all"]

