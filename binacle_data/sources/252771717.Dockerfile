FROM ubuntu:16.04  
RUN apt-get update  
RUN apt-get install libfontconfig curl bzip2 -y  
RUN curl -sL https://deb.nodesource.com/setup_9.x nodesource_setup.sh | bash  
RUN apt-get install nodejs -y  
  
WORKDIR /root  
RUN npm install phantomjs-prebuilt pageres pageres-cli  
  
ADD entrypoint.sh /entrypoint.sh  
ADD map.js /map.js  
  
WORKDIR /  
ENTRYPOINT ["/entrypoint.sh"]  

