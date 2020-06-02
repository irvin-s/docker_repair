FROM ubuntu:14.04  
MAINTAINER Nick Portokallidis <portokallidis@gmail.com>  
  
RUN apt-get update && apt-get install -y wget git apache2  
  
EXPOSE 80

