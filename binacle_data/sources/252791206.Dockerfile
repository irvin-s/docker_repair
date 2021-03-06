FROM postgres  
MAINTAINER Florian Lambert <florian.lambert@cycloid.io>  
  
RUN apt-get update && \  
apt-get install python-pip cron vim -y && \  
pip install awscli && \  
rm -fr /var/cache/apk/* /var/lib/apt/lists/*  
  
RUN mkdir -p /backup  
COPY scripts /scripts  
  
WORKDIR /scripts  
  
ENTRYPOINT ["/scripts/entrypoint.sh"]  

