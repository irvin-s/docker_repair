FROM ubuntu:16.04  
MAINTAINER Asofe Pool "develnk@gmail.com"  
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list  
RUN apt-get update  
RUN apt-get upgrade -y  
RUN apt-get install -y curl git build-essential gcc libsodium-dev  
  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -  
RUN apt-get install -y nodejs  
  
RUN npm install n -g \  
&& n v8.9.4  
  
RUN cd / \  
&& git clone https://github.com/TheLightSide/asofe_pool.git \  
&& cd /asofe_pool \  
&& npm update \  
&& npm install  
  
WORKDIR /asofe_pool  
  
EXPOSE 8080 17117  
CMD ["npm", "start"]  

