FROM debian:jessie  
  
MAINTAINER dario dario@dariozanzico.com  
  
RUN \  
apt-get update && \  
apt-get install -y openssl heirloom-mailx && \  
rm -fr /var/lib/apt/lists/*  
  
COPY files/ssl-cert-check-v3.29 /ssl-cert-check  
COPY files/run.sh /run.sh  
COPY files/mailrc.template /tmp/  
  
RUN chmod +x /ssl-cert-check  
RUN chmod +x /run.sh  
  
CMD /run.sh  
  

