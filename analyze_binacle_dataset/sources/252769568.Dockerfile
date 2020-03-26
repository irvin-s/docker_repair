ARG ubuntuVersion=18.04  
FROM ubuntu:${ubuntuVersion}  
MAINTAINER Peter Mount <peter@retep.org>  
  
## for apt to be noninteractive  
ENV DEBIAN_FRONTEND noninteractive  
ENV DEBCONF_NONINTERACTIVE_SEEN true  
# Update apt. Unlike most builds we will keep this in place  
# Force timezone as this hangs builds waiting for a response  
# See https://stackoverflow.com/a/47909037  
RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \  
echo "tzdata tzdata/Zones/Europe select London" >> /tmp/preseed.txt; \  
debconf-set-selections /tmp/preseed.txt && \  
rm -rf /etc/timezone /etc/localtime && \  
apt-get update &&\  
apt-get install -y \  
tzdata \  
apt-transport-https \  
ca-certificates \  
curl \  
libcurl4-openssl-dev \  
s3cmd \  
sudo \  
unzip \  
vim \  
zip \  
aufs-tools \  
autoconf \  
automake \  
build-essential \  
cvs \  
git \  
mercurial \  
reprepro \  
subversion \  
make \  
gcc \  
g++ \  
python \  
paxctl &&\  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

