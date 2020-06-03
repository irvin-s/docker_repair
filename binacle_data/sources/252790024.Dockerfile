FROM nginx  
MAINTAINER Hervé Bredin <bredin@limsi.fr>  
  
COPY html /usr/share/nginx/html  
COPY run.sh /app/run.sh  
  
ENTRYPOINT ["/bin/bash", "/app/run.sh"]  

