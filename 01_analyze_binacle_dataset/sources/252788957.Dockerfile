FROM ubuntu:16.04  
MAINTAINER drpaulbrewer@eaftc.com  
RUN useradd -m webdis  
COPY webdis.json /home/webdis/  
RUN apt-get update && \  
apt-get install --yes git-core build-essential libevent-dev && \  
git clone https://github.com/nicolasff/webdis.git && \  
cd /webdis && \  
make && \  
sed -i '/redis_host/s/"127.*"/"redis"/g' webdis.json && \  
make install && \  
rm -rf /webdis && \  
apt-get remove --yes git-core build-essential libevent-dev && \  
apt --yes autoremove && \  
apt-get --yes install libevent-2.0.5  
USER webdis  
WORKDIR /home/webdis  
CMD /usr/local/bin/webdis  

