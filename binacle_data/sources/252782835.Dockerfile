FROM ubuntu:16.04  
  
LABEL \  
maintainer="Davide Alberani <da@erlug.linux.it>"  
  
RUN \  
apt-get update && \  
apt-get -y --no-install-recommends install \  
bc \  
build-essential \  
default-jre \  
device-tree-compiler \  
gawk \  
git \  
gperf \  
libexpat1-dev \  
libjson-perl \  
libncurses5-dev \  
lzop \  
patchutils \  
texinfo \  
unzip \  
wget \  
xfonts-utils \  
xsltproc \  
zip && \  
echo "yes" | cpan && \  
cpan -i XML::Parser && \  
rm -rf /var/lib/apt/lists/*  
  
RUN useradd -ms /bin/bash orangepi  
  
COPY . /home/orangepi  
  
VOLUME \  
/home/orangepi/target \  
/home/orangepi/sources  
  
RUN chown -R orangepi:orangepi /home/orangepi  
  
USER orangepi:orangepi  
  
WORKDIR /home/orangepi  
  
ENV \  
ARCH=arm \  
PROJECT=H3  
  
ENTRYPOINT ["./entrypoint.sh"]  

