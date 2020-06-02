FROM ubuntu:17.10  
RUN apt-get update && \  
apt-get install -y python-pip  
RUN pip install shadowsocks  
  
ENTRYPOINT ["/usr/local/bin/ssserver"]

