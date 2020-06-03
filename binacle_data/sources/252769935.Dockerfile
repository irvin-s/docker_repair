FROM nginx  
LABEL maintainer "Daniel Gerhardt <code@z.dgerhardt.net>"  
  
RUN \  
apt-get update && \  
apt-get install -y --no-install-recommends \  
curl && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
COPY etc/nginx/conf.d/arsnova.conf /etc/nginx/conf.d/  
  
RUN rm /etc/nginx/conf.d/default.conf  
  
COPY docker-entrypoint.sh /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD []  

