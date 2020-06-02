FROM python:2.7-alpine  
MAINTAINER "EEA IDM-1" http://www.eea.europa.eu  
  
ENV IMAGE_NAME=EEA-centos7-generic-v2.1 \  
INSTANCE_NAME='' \  
INSTANCE_FLAVOR='e2standard.x5' \  
INSTANCE_ROOT_SIZE=10 \  
INSTANCE_ROOT_PERSISTENT=false \  
INSTANCE_DOCKERSTORAGE_SIZE=32 \  
INSTANCE_DOCKERSTORAGE_TYPE=standard \  
INSTANCE_DOCKER_VOLUME=true \  
INSTANCE_DOCKER_VOLUME_TYPE=standard \  
INSTANCE_DOCKER_VOLUME_SIZE=10 \  
TIMEOUT=40  
RUN set -e \  
&& apk add --no-cache --update build-base linux-headers ca-certificates \  
&& pip install python-openstackclient==2.3.0 \  
&& apk del --purge build-base linux-headers \  
&& rm -f /var/cache/apk/*  
  
COPY create_dockerhost.sh /  
COPY user_data.file /  
  
ENTRYPOINT ["/create_dockerhost.sh"]  
CMD [""]  
  

