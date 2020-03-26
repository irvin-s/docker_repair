FROM iojs:2.3.3  
MAINTAINER Ainsley Chong <ainsley.chong@gmail.com>  
  
RUN git clone https://github.com/etsy/statsd.git /opt/statsd  
ADD conf/config.js.mustache /opt/statsd/config.js.mustache  
ADD scripts/build_configs /opt/statsd/build_configs  
  
WORKDIR /opt/statsd  
RUN npm install mustache  
  
CMD ["/opt/statsd/build_configs"]  

