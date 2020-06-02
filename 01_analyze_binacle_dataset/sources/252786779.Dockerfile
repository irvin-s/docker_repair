FROM ubuntu:17.04  
ENV DEBIAN_FRONTEND=noninteractive  
RUN apt-get update -y && \  
apt-get -y install \  
make \  
subversion \  
g++ \  
zlib1g-dev \  
build-essential \  
git \  
python \  
rsync \  
man-db \  
libncurses5-dev \  
gawk \  
gettext \  
unzip \  
file \  
libssl-dev \  
wget  
  
RUN git clone https://git.lede-project.org/source.git /opt/lede  
WORKDIR /opt/lede  
RUN git checkout lede-17.01  
RUN git reset --hard lede-17.01  
  
COPY script.sh /opt/script.sh  
  
WORKDIR /opt/  
RUN chmod +x script.sh  
CMD ["./script.sh"]  
VOLUME /opt/targets  

