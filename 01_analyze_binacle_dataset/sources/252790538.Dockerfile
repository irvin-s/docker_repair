FROM debian:sid  
MAINTAINER Anton Lindström <carlantonlindstrom@gmail.com>  
  
RUN apt-get update && \  
apt-get install -y gcc make git && \  
rm -rf /var/lib/apt/lists/* && \  
cd /root && \  
git clone https://github.com/kynesim/tstools.git && \  
cd tstools && \  
make && \  
make install && \  
apt-get purge -y gcc make git && \  
apt autoremove -y && \  
rm -rf /root/tstools  
  

