FROM node:slim  
MAINTAINER Ido Shamun <idoesh1@gmail.com@gmail.com>  
RUN adduser --disabled-password --gecos "" sinopia  
RUN mkdir -p /opt/sinopia  
RUN mkdir -p /mnt/data/storage  
RUN chown -R sinopia:sinopia /mnt/data  
WORKDIR /opt/sinopia  
RUN npm install sinopia  
ADD /start.sh /opt/sinopia/start.sh  
RUN chown -R sinopia:sinopia /opt/sinopia  
USER sinopia  
CMD ["/opt/sinopia/start.sh"]  
  
EXPOSE 4873  
VOLUME /mnt/data

