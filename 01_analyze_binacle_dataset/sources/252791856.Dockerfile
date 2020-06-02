FROM chambana/base:latest  
  
MAINTAINER Josh King <jking@chambana.net>  
  
ENV PDNS_SUPERMASTERS ""  
RUN apt-get -qq update && \  
apt-get install -y --no-install-recommends pdns-server && \  
apt-get clean && rm -rf /var/lib/apt/lists/*  
  
EXPOSE 53  
ADD files/bindbackend.conf /etc/powerdns/bindbackend.conf  
ADD files/pdns.local.conf /etc/powerdns/pdns.d/pdns.local.conf  
  
VOLUME ["/zones"]  
  
## Add startup script.  
ADD bin/run.sh /app/bin/run.sh  
RUN chmod 0755 /app/bin/run.sh  
  
ENTRYPOINT ["/app/bin/run.sh"]  
CMD ["pdns_server", "--daemon=no"]  

