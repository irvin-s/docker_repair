FROM ubuntu:16.04  
RUN mkdir /compilers-ms  
  
RUN apt-get update  
RUN apt-get install curl -y  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash  
RUN apt-get install nodejs -y  
RUN npm install express-generator -g  
RUN mkdir /compilers-ms/temp  
RUN apt-get install gcc -y  
RUN apt-get install python3 -y  
  
WORKDIR /compilers-ms  
  
COPY ./key-storage.json /compiler-ms/key-storage.json  
RUN export GOOGLE_APPLICATION_CREDENTIALS="/compiler-ms/key-storage.json"  
ADD compiler/package.json /compilers-ms/package.json  
ADD compiler/package-lock.json /compilers-ms/package-lock.json  
  
RUN npm install  
  
ADD . /compilers-ms  
  
EXPOSE 8010  

