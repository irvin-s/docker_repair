FROM nginx:alpine  
MAINTAINER SteamCache.Net Team <team@steamcache.net>  
ENV GENERICCACHE_VERSION 1  
ENV WEBUSER nginx  
ENV CACHE_MEM_SIZE 500m  
ENV CACHE_DISK_SIZE 190000m  
ENV CACHE_MAX_AGE 3560d  
COPY overlay/ /  
VOLUME ["/srv/cache"]  
EXPOSE 80  
WORKDIR /scripts  
ENTRYPOINT ["/scripts/bootstrap.sh"]  

