FROM node:argon  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
RUN apt-get update  
RUN apt-get -y install mongodb  
  
COPY package.json /usr/src/app/  
RUN npm install  
  
COPY . /usr/src/app  
  
ENV APP_ID myAppId  
ENV MASTER_KEY mySecretMasterKey  
ENV FILE_KEY optionalFileKey  
ENV USER_NAME user  
ENV PASSWORD pass  
ENV SERVER_URL http://localhost:8080  
ENV DOTNET_KEY myDotNetKey  
ENV CLIENT_KEY myClientKey  
  
RUN bash install_dashboard.sh  
  
EXPOSE 8080 27017 4040  
ENTRYPOINT bash /usr/src/app/start_server.sh  

