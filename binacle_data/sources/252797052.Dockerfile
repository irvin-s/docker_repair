FROM cloudfleet/haraka  
  
COPY . /usr/src/app  
  
RUN groupadd -r node \  
&& useradd -r -g node node  
  
RUN mkdir /usr/src/app/queue && chown -R node:node /usr/src/app  
  
EXPOSE 25  
WORKDIR /usr/src/app  
CMD ./start.sh  

