FROM cascadeo/kops  
  
MAINTAINER Prem Rara version: 0.1  
COPY ./docker-entrypoint.sh /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  

