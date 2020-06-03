FROM swiftdocker/swift  
  
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -  
RUN apt-get install -y nodejs  
  
ADD . /home  
RUN cd /home && npm install  
  
ENTRYPOINT node /home/app.js  
  
ENV PORT 8080  
EXPOSE 8080  

