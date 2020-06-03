FROM alpine:3.2  
ENV STATSD_VERSION=0.7.2  
ENV INFLUX_BE_VERSION=0.6.0  
ADD https://github.com/etsy/statsd/archive/v${STATSD_VERSION}.tar.gz /tmp/  
RUN tar xzf /tmp/v${STATSD_VERSION}.tar.gz && \  
mv statsd-${STATSD_VERSION} /statsd && \  
apk -U add nodejs && \  
npm install statsd-influxdb-backend@${INFLUX_BE_VERSION} && \  
rm -r /var/cache/apk/*  
ADD config.js /statsd/config.js  
  
EXPOSE 8125/udp 8126  
ENTRYPOINT [ "/statsd/bin/statsd" ]  
CMD [ "/statsd/config.js" ]  

