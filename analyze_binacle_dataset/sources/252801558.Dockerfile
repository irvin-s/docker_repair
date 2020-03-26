FROM alpine:latest  
LABEL net.easypo.docker.software="beanstalkd"  
RUN apk update ;\  
apk upgrade ;\  
apk add beanstalkd  
VOLUME /data  
EXPOSE 11300  
ENTRYPOINT ["/usr/bin/beanstalkd", "-b", "/data", "-c", "-f", "1000"]  
STOPSIGNAL 15  

