FROM ubuntu:14.04  
MAINTAINER Brice Argenson <brice@clevertoday.com>  
  
RUN apt-get update -y && \  
apt-get install -y graphite-carbon && \  
echo "CARBON_CACHE_ENABLED=true" > /etc/default/graphite-carbon  
  
VOLUME /var/lib/graphite  
  
COPY docker-entrypoint.sh /  
COPY config/cache.conf /etc/carbon/cache.conf  
COPY config/relay.conf /etc/carbon/relay.conf  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
EXPOSE 2003 2004 7002 2013 2014  
CMD ["cache"]

