FROM node  
MAINTAINER CenturyLink  
EXPOSE 3000  
RUN apt-get update  
RUN apt-get upgrade -y  
RUN apt-get install -y wget  
  
WORKDIR /  
RUN mkdir stackedit  
RUN wget https://github.com/benweet/stackedit/archive/v3.1.14.tar.gz  
RUN tar -xzf v3.1.14.tar.gz  
  
WORKDIR /stackedit-3.1.14  
RUN npm install  
CMD node server.js  

