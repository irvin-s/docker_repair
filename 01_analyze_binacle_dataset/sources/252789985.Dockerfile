# Job Kue  
# Kue.js  
# Redis  
FROM ubuntu:16.04  
MAINTAINER Ganesh Iyer "lastlegion@gmail.com"  
### update  
RUN apt-get -q update  
RUN apt-get -q -y upgrade  
RUN apt-get -q -y dist-upgrade  
  
RUN apt-get -y install redis-server  
RUN apt-get -y install nodejs npm  
  
RUN ln -s "$(which nodejs)" /usr/bin/node  
  
RUN npm install yargs #Unlisted kue dependency  
  
RUN apt-get -y install git  
  
WORKDIR /root/  
  
#RUN git clone https://github.com/Automattic/kue.git  
#WORKDIR /root/kue  
RUN git clone https://github.com/camicroscope/OrderingService.git  
WORKDIR /root/OrderingService  
  
RUN npm install  
  
#RUN ln -s "$(which nodejs)" /usr/bin/node  
RUN npm install -g forever  
  
WORKDIR /root  
COPY run.sh /root/  
COPY redis.conf /etc/redis/redis.conf  
CMD ["sh", "run.sh"]  
  
#RUN forever start /root/OrderingService/node_modules/kue/bin/kue-dashboardai  

