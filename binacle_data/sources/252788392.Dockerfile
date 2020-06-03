FROM node  
MAINTAINER Ido Shamun <idoesh1@gmail.com>  
  
RUN apt-get update && \  
apt-get install -y git wget python netcat  
  
VOLUME /home/root/config  
VOLUME /usr/local/share/ca-certificates/private  
  
ENV NODE_ENV production  
  
ADD install.sh ./  
RUN ./install.sh  
  
ADD run.sh ./  
CMD ./run.sh  
  
EXPOSE 3000  

