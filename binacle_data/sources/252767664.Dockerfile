FROM ubuntu:14.04  
MAINTAINER Joshua Noble <acejam@gmail.com>  
  
WORKDIR /root  
ENV RPC_USER bitmessagerpc  
ENV RPC_PASS P@ssw0rd  
ENV RPC_INTERFACE localhost  
  
RUN apt-get update && \  
apt-get install -y python openssl git && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN git clone https://github.com/Bitmessage/PyBitmessage  
COPY docker-entrypoint.sh /usr/local/bin/  
ENTRYPOINT ["docker-entrypoint.sh"]  
  
EXPOSE 8444 8442  
VOLUME ["/root/.config/PyBitmessage"]  
CMD ["/usr/bin/python", "/root/PyBitmessage/src/bitmessagemain.py"]  

