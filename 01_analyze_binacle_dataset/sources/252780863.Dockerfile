FROM nginx:1.13  
# Setup for letsencrypt  
RUN runtimeDeps='inotify-tools openssl' \  
&& apt-get update && apt-get install -y $runtimeDeps \--no-install-recommends  
VOLUME /etc/nginx/dhparam  
  
# Cleanup nginx  
RUN rm /etc/nginx/conf.d/default.conf  
  
# Copy configuration files  
COPY files/ /  
  
# Use application path  
WORKDIR /app  
  
# Run  
ENTRYPOINT ["/run.sh"]  

