FROM debian:jessie  
  
MAINTAINER David M. Lee, II <leedm777@yahoo.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && \  
apt-get install -y --no-install-recommends \  
exim4 \  
net-tools \  
curl \  
python-pip && \  
pip install j2cli && \  
apt-get purge -y --auto-remove && rm -rf /var/lib/apt/lists/*  
  
# Debugging tools  
#RUN apt-get update && apt-get install -y vim netcat  
COPY conf /etc/exim4  
COPY docker-entrypoint.sh /  
  
ENV SMTP_USERNAME= SMTP_PASSWORD= AWS_REGION= DC_RELAY_NETS=  
EXPOSE 25  
VOLUME ["/data/ses-relay"]  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["/usr/sbin/exim", "-DSPOOLDIR=/data/ses-relay/spool", "-bd", "-v"]  

