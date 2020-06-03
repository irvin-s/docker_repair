FROM abstracttechnology/webapp:latest  
MAINTAINER Simone Deponti <simone.deponti@abstract.it>  
  
RUN \  
apt-get update && \  
apt-get install -y postgresql-client postgresql-contrib && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
USER webapp  
  
RUN mkdir -p /srv/webapp/var && \  
mkdir -p /srv/webapp/static && \  
mkdir -p /srv/webapp/media  
  
COPY manage.py manage.py  
COPY check_up.bash check_up.bash  
COPY docker-entrypoint.sh docker-entrypoint.sh  
  
VOLUME ["/srv/webapp/var","/srv/webapp/static","/srv/webapp/media"]  
  
ENTRYPOINT ["/srv/webapp/docker-entrypoint.sh"]  
CMD ["run"]  

