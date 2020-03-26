FROM ubuntu:latest  
  
WORKDIR /opt  
RUN sudo apt-get install -y git curl  
RUN git clone https://github.com/echeadle/hapi-example.git  
  
RUN curl -sL https://deb.nodesource.com/setup | sudo bash -  
RUN sudo apt-get update && sudo apt-get -y upgrade  
RUN sudo apt-get install -y nodejs  
  
WORKDIR /opt/hapi-example/webserver  
  
RUN /usr/bin/npm install  
  
CMD ["/usr/bin/node", "index.js"]  

