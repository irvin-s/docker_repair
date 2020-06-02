FROM ubuntu:16.04  
RUN apt-get update \  
&& apt-get install -y jq curl iputils-ping \  
&& apt-get clean  
  
COPY docker-entrypoint.sh /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  

