FROM node:7-alpine  
MAINTAINER Jan Kohlhof <kohj@informatik.uni-marburg.de>  
  
ENV STATSD_VERSION "master"  
RUN apk add --update ca-certificates wget && \  
update-ca-certificates && \  
wget https://github.com/etsy/statsd/archive/${STATSD_VERSION}.zip && \  
unzip ${STATSD_VERSION}.zip && \  
rm ${STATSD_VERSION}.zip && \  
mv /statsd-* /statsd  
  
ADD config.js /statsd/config.js  
ADD startup.sh /startup.sh  
  
EXPOSE 8125/udp  
ENTRYPOINT ["/startup.sh"]  

