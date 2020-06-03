FROM node:9.3.0  
RUN apt-get update;  
RUN apt-get install -y vim;  
  
RUN npm install -g create-react-app  
RUN create-react-app admin  
RUN cd /admin && yarn add admin-on-rest  
WORKDIR /admin  
  
EXPOSE 3000  
ADD docker-entrypoint.sh /docker-entrypoint.sh  
ENTRYPOINT [ "/docker-entrypoint.sh" ]  

