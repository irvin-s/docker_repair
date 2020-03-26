FROM ubuntu  
  
MAINTAINER brendan@codeship.com  
  
RUN apt-get update && apt-get install -y curl  
RUN curl -sSL https://experimental.docker.com/ | sh  
  
ADD . .  
  
ENTRYPOINT ["control.sh"]  

