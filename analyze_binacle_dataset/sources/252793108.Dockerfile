FROM dankempster/node:latest  
  
MAINTAINER dev@dankempster.co.uk  
  
RUN set -x; \  
apt-get update; \  
apt-get install -y unzip --no-install-recommends; \  
apt-get clean; \  
rm -rf /var/lib/apt/lists/*; \  
npm install -g bower;  
  
COPY .bowerrc /  
  
RUN set -x; \  
mkdir -p /bower/links; \  
mkdir /bower/packages; \  
mkdir /bower/repository; \  
\  
chown -R www-data:www-data /bower; \  
chown www-data:www-data /.bowerrc; \  
\  
chmod -R 2775 /bower; \  
chmod -R 0664 /.bowerrc;  
  
VOLUME /bower  
  
USER www-data  
  
#ENTRYPOINT bower  
CMD [ "bower" ]

