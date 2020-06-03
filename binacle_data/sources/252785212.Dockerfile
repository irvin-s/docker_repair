# Cron  
# Cogset Open Source Group  
FROM debian:jessie  
  
MAINTAINER Cogset <cogset@funcuter.org>  
  
# Install  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends cron \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY docker-entrypoint.sh /usr/local/bin/  
RUN chmod +x /usr/local/bin/docker-entrypoint.sh  
  
ENTRYPOINT ["docker-entrypoint.sh"]  
  
CMD ["tail"]  

