FROM nginx  
  
LABEL maintainer "Charlie McClung <charlie@bowtie.co>"  
  
# Configure ENV var for nginx installation path  
ENV NGINX_INSTALL_PATH /etc/nginx  
  
# Remove default nginx config  
RUN rm $NGINX_INSTALL_PATH/conf.d/default.conf  
  
# Delete the default welcome to nginx page (if it exists)  
RUN [ -d /usr/share/nginx/html ] && rm /usr/share/nginx/html/*  
  
# Copy config files  
COPY conf.d/*.conf $NGINX_INSTALL_PATH/conf.d/  
  
# Test nginx config  
RUN nginx -t  
  
# Copy docker entrypoing script  
COPY docker-entrypoint.sh /  
  
# Allow us to customize the entrypoint of the image.  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
# Start nginx in the foreground to play nicely with Docker.  
CMD ["nginx", "-g", "daemon off;"]  

