FROM ubuntu:wily  
RUN apt-get update  
RUN apt-get -y --force-yes install curl  
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -  
RUN apt-get -y --force-yes install nodejs  
RUN npm install -g live-server  
RUN npm install -g webpack  
COPY . /opt/layer  
WORKDIR /opt/layer  
RUN npm install  
RUN webpack  
EXPOSE 8080  
CMD live-server --port=8080 dist

