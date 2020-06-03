FROM debian:jessie  
  
RUN apt-get update \  
&& apt-get install -y -qq curl python python-pip \  
&& rm -rf /var/lib/apt/lists/* \  
&& pip install awscli \  
&& mkdir /var/letsencrypt  
  
ADD letsencrypt /var/letsencrypt  
  
ENV LETS_ENCRYPT_CA=https://acme-staging.api.letsencrypt.org/directory \  
RUN_INTERVAL=10  
  
CMD ["/var/letsencrypt/run.sh"]

