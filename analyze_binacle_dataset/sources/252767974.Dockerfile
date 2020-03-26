FROM node:0.10  
RUN git clone https://github.com/etsy/statsd.git  
RUN cd /statsd && npm install statsd-instrumental-backend  
  
ADD config.js /statsd/config.js  
  
EXPOSE 8125/udp  
EXPOSE 8126/tcp  
  
CMD /usr/local/bin/node /statsd/stats.js /statsd/config.js  

