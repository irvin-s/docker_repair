FROM debian  
  
RUN apt-get update -y && apt-get install -y curl  
  
ADD . /scripts/  
WORKDIR /scripts/  
  
ENTRYPOINT ["sh", "/scripts/init.sh"]  
  

