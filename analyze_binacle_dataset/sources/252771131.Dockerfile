FROM perl:5  
MAINTAINER Andrew Watts <ahwatts@gmail.com>  
  
RUN cpanm -f MogileFS::Server@2.72 && \  
cpanm -f DBD::mysql && \  
rm -rf /root/.cpanm  
  
ADD entrypoint.sh /entrypoint.sh  
RUN useradd -s /bin/bash -m -c "mogilefsd user" mogilefsd && \  
mkdir -p /etc/mogilefs && \  
chown -R mogilefsd:mogilefsd /etc/mogilefs && \  
chmod 0755 /entrypoint.sh  
  
EXPOSE 7001  
USER mogilefsd  
WORKDIR /  
CMD ["/entrypoint.sh"]  

