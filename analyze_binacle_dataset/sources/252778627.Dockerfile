FROM ubuntu:trusty  
  
RUN apt-get update  
RUN apt-get -y install nodejs npm  
RUN apt-get -y install build-essential  
  
COPY . /src  
  
WORKDIR /src  
  
RUN npm install  
  
# RUN ls /src -lRrt  
EXPOSE 3000  
#RUN cd /src; nodejs app.js  
CMD ["nodejs", "app.js"]  

