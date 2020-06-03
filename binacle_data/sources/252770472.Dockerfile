FROM ubuntu:trusty  
MAINTAINER Qiang Li  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV TERM linux  
ENV HOME /root  
  
####  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
apt-utils \  
ca-certificates \  
curl \  
dnsutils\  
libblas3gf \  
libcurl4-openssl-dev \  
libfftw3-dev \  
libicu52 \  
liblapack3gf \  
libxml2-dev \  
git \  
unzip \  
wget \  
&& apt-get clean \  
&& rm -rf \  
/var/lib/apt/lists/* \  
/tmp/* \  
/var/tmp/* \  
/usr/share/man \  
/usr/share/doc \  
/usr/share/doc-base  
  
##  
RUN git clone https://github.com/asperitus/R.git /opt/R \  
&& sed -i 's#/app/vendor/R/#/opt/R/#g' /opt/R/bin/R  
##  
RUN ln -sf bash /bin/sh  
  
ENV PATH /opt/R/bin:$PATH  
  
####  
WORKDIR /app  
  
CMD ["bash"]  
##

