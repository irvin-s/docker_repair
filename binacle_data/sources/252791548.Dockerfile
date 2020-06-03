FROM ubuntu:latest  
  
MAINTAINER daGrevis  
  
RUN apt-get -y update  
RUN apt-get install -y npm  
RUN npm install -g peer  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
  
EXPOSE 9000  
  
ENTRYPOINT ["peerjs", "--port", "9000"]  

