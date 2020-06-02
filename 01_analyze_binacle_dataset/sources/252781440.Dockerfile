FROM banian/nginx-extras  
  
VOLUME /var/cache/mirror  
CMD entrypoint  
  
ENV server_name '$server_name'  
ENV upstream_cache_status '$upstream_cache_status'  
ENV http_user_agent '$http_user_agent'  
ENV REMOTE_PROTOCOLE 'https'  
ENV REMOTE_HOST ''  
ENV CACHE_TTL '5m'  
ENV MAX_CACHE_SIZE '10g'  
ENV MAX_CLIENT_CONNECTED ''  
ENV CACHE_LOCK_TIMEOUT '10s'  
ENV CACHE_INACTIVE '3M'  
COPY default.template /etc/nginx  
COPY entrypoint /bin  

