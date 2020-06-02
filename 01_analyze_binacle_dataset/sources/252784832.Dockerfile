FROM debian:8-slim  
MAINTAINER Josh VanderLinden <codekoala@gmail.com>  
  
RUN apt-get update && \  
apt-get install -y ca-certificates  
  
ADD ./bin/aws-sign-proxy /bin/  
  
ENTRYPOINT /bin/aws-sign-proxy  

