# DOCKER-VERSION 1.3  
# AUTHOR: Minku Lee <minku@sha.kr>  
# DESCRIPTION: Out-of-the-box StatsD + InfluxDB backend image for Docker  
FROM node:0.12.7-slim  
  
RUN apt-get update && apt-get install -y git  
RUN git clone https://github.com/etsy/statsd.git  
RUN cd /statsd && npm install statsd-influxdb-backend  
  
ADD config.js /statsd/config.js  
  
EXPOSE 8125/udp  
EXPOSE 8126/tcp  
  
CMD /usr/local/bin/node /statsd/stats.js /statsd/config.js  

