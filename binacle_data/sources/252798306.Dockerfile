FROM nginx:1.13-alpine  
LABEL maintainer="Demandbase DevOps <devops@demandbase.com>"  
  
# Add in the config  
COPY nginx.conf.proxy_protocol /etc/nginx/nginx.conf  

