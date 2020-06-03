  
FROM aomeri/fineract-base:latest  
  
MAINTAINER Antony Omeri, antonyomeri@gmail.com  
  
WORKDIR /app  
  
CMD ["/bin/bash", "./build.sh"]

