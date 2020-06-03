FROM 1and1internet/ubuntu-16-nginx:latest  
MAINTAINER Brian Wojtczak <brian.wojtczak@1and1.co.uk>  
ARG DEBIAN_FRONTEND=noninteractive  
ENV \  
CELERY_BROKER_URL=amqp://guest:guest@rabbitmq:5672// \  
CELERY_BROKER_API=http://guest:guest@rabbitmq:15672/api/ \  
HTTP_USERNAME=flower \  
HTTP_PASSWORD=insecure  
COPY files /  
RUN \  
apt-get update && \  
apt-get install -y python-dev python-pip apache2-utils && \  
pip install --upgrade pip && \  
pip install flower && \  
apt-get autoremove -y && \  
rm -rf /var/lib/apt/lists/* && \  
chmod 666 /etc/nginx/sites-enabled/site.conf && \  
mkdir -p /flower/ && \  
chmod 777 /flower/  
WORKDIR /flower/  
VOLUME /flower  

