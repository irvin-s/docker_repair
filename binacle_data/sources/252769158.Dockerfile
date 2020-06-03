FROM debian:squeeze  
ADD squeeze_sources.list /etc/apt/sources.list  
RUN apt-get update  
RUN apt-get install --yes openssl  
ADD DROWNcheck.sh /root/DROWNcheck.sh  
ENTRYPOINT ["/bin/bash", "/root/DROWNcheck.sh"]

