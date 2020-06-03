FROM ubuntu:trusty  
  
MAINTAINER Anteneh Aklilu "reachanteneh@gmail.com"  
RUN apt-get update && apt-get install -y \  
bison \  
build-essential \  
libssl-dev \  
libxml2-dev \  
supervisor \  
wget  
  
RUN cd /usr/src/ && \  
#Download the kannel source tarball  
wget http://kannel.org/download/1.4.3/gateway-1.4.3.tar.gz && \  
##Extract kannel files from the tarball  
tar xzf gateway-1.4.3.tar.gz && \  
#Install kannel  
cd /usr/src/gateway-1.4.3 && \  
./configure --prefix=/usr/local/kannel --sysconfdir=/etc/kannel && \  
touch .depend && \  
make && make install && \  
#Remove kannel sources  
cd /usr/src/ && \  
rm gateway-1.4.3.tar.gz && \  
#Remove extracted kannel source directory  
rm -Rf gateway-1.4.3 && \  
#Create directories required by kannel  
mkdir -p /var/log/kannel && \  
mkdir -p /var/spool/kannel  
  
COPY conf/* /etc/kannel/  
  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
EXPOSE 13013 13000  
VOLUME [/etc/kannel, /var/log/kannel, /var/spool/kannel]  
  
CMD ["/usr/bin/supervisord"]  

