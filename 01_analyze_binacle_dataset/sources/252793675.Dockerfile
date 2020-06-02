FROM ubuntu:12.04  
MAINTAINER ralphmeier79@gmail.com  
  
RUN apt-get update  
RUN echo yes | apt-get install curl  
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -  
RUN apt-get install -y nodejs  
  
# Copy app to /opt  
COPY . /opt  
  
# Install app and dependencies into /opt  
RUN cd /opt; npm install  
  
EXPOSE 8080  
CMD cd /opt && node ./app.js  

