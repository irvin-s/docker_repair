FROM dock0/service  
MAINTAINER Jon Chen <bsd@voltaire.sh>  
  
VOLUME /opt/secrets/tls  
  
ADD https://dl.bintray.com/jchen/docku/latest/certstrap /usr/sbin/certstrap  
RUN chmod +x /usr/sbin/certstrap  
  
RUN mkdir -p /opt/secrets/tls  
  
WORKDIR /opt/secrets/tls  
ENTRYPOINT ["/usr/sbin/certstrap"]  

