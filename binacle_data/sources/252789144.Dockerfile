FROM dsop/alpine-nodejs:6.9.2  
  
ENV STATSD 0.8.0  
  
RUN \  
apk --update add python make gcc g++ && \  
USER=root npm install --global statsd@${STATSD} && \  
apk --purge del python make gcc g++ && \  
npm cache clean && \  
cd /usr/lib/node_modules && \  
npm uninstall -y npm && \  
mkdir -p /etc/statsd && \  
cp /usr/lib/node_modules/statsd/exampleConfig.js /etc/statsd/config.js  
  
WORKDIR /usr/lib/node_modules/statsd/  
  
ENTRYPOINT ["/usr/bin/node", "stats.js"]  
  
CMD ["/etc/statsd/config.js"]  
  
EXPOSE 8125 8126  

