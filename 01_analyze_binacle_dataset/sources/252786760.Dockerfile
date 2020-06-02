FROM nginx:alpine  
  
# Variables.  
ENV ROOT /webs  
  
RUN mkdir -p $ROOT  
WORKDIR $ROOT  
  
COPY blog.botanicus.me/build $ROOT/blog.botanicus.me  
COPY api.botanicus.me $ROOT/api.botanicus.me  
  
# Override the existing default vhost.  
COPY vhost.conf /etc/nginx/sites-enabled/botanicus.me.vhost  
COPY nginx.conf /etc/nginx/nginx.conf  

