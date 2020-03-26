FROM dsop/alpine-base  
  
RUN apk --update add alpine-sdk && \  
apk add autoconf && \  
apk add automake  
  
RUN cd /tmp && \  
git clone https://github.com/adidas-dsop/statsd-proxy.git && \  
cd statsd-proxy && \  
./autogen.sh && \  
./configure && \  
make && \  
cp statsd-proxy /usr/local/bin && \  
cp example.cfg /etc/statsd-proxy.cfg  
  
RUN apk del alpine-sdk && \  
apk del autoconf && \  
apk del automake && \  
rm -rf /var/cache/apk/* && \  
rm -rf /tmp/*  
  
ENTRYPOINT ["/usr/local/bin/statsd-proxy", "-f"]  
  
CMD ["/etc/statsd-proxy.cfg"]  
  
EXPOSE 8125/udp  

