FROM onosproject/onos:1.2  
MAINTAINER David Bainbridge <dbainbri@ciena.com>  
COPY ./onos-service /root/onos/bin/onos-service  
RUN chmod 755 /root/onos/bin/onos-service  
ENTRYPOINT ["./bin/onos-service"]  

