FROM alpine  
  
RUN apk add --no-cache \  
bash \  
bash-completion \  
bzip2 \  
gzip \  
tar \  
curl \  
wget \  
rsync \  
lftp \  
supervisor  
  
RUN mkdir /opt /opt/scripts  
RUN mkdir /etc/supervisord.d  
  
COPY scripts/* /opt/scripts/  
  
RUN chmod +x -R /opt/scripts  
  
ADD fs/etc/supervisord.conf /etc/supervisord.conf  
ADD fs/etc/supervisord.d/* /etc/supervisord.d/  
  
CMD [ "/opt/scripts/setup-and-run.sh"]

