#  
# carbon  
#  
# Pull base image.  
FROM ashangit/base:latest  
MAINTAINER Nicolas Fraison <nfraison@yahoo.fr>  
  
# Deploy carbon.  
RUN yum install python-carbon -y  
  
# Create required folders  
RUN mkdir -p /data/carbon/conf && \  
mkdir -p /data/carbon/data  
  
# Set working directory  
WORKDIR /data/carbon  
  
# Copy default config file  
COPY conf/carbon.conf /data/carbon/conf/carbon.conf  
COPY conf/storage-schemas.conf /data/carbon/conf/storage-schemas.conf  
  
# Declare default env variables  
ENV GRAPHITE_ROOT /data/carbon  
ENV GRAPHITE_CONF_DIR /data/carbon/conf  
ENV GRAPHITE_STORAGE_DIR /data/carbon/data  
  
# Expose carbon port  
EXPOSE 2003 2004 7002  
COPY docker-entrypoint.sh /entrypoint.sh  
RUN chmod 750 /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
  
# Default command  
CMD [ "carbon-cache", "--debug", "start" ]

