FROM nginx  
COPY start /usr/local/bin/start  
RUN mkdir -p /cache && chown -R nginx:nginx /cache  
VOLUME /cache  
CMD start  

