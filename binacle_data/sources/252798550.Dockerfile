FROM debian:9  
RUN set -uex; \  
apt-get update; \  
apt-get install -y unbound;  
  
COPY unbound.aws.conf /etc/unbound/unbound.conf  
COPY scripts /scripts/  
  
CMD unbound -d  
  

