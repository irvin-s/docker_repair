FROM alpine  
  
LABEL maintainer="anthony@relle.co.uk" \  
izone_version="3.434"  
  
RUN apk --update upgrade && \  
apk add --no-cache --virtual=temporary curl gcc make build-base && \  
curl -o /tmp/iozone.tar http://www.iozone.org/src/current/iozone3_434.tar && \  
cd /tmp && \  
tar -xf /tmp/iozone.tar && \  
cd /tmp/iozone*/src/current && \  
make linux && \  
cp iozone /usr/bin/iozone && \  
apk del temporary && \  
rm -rf /var/cache/apk/* /tmp/iozone*  
  
ENTRYPOINT ["/usr/bin/iozone"]  
CMD ["-e","-I","-a","-s","100M","-r","4k","-i","0","-i","1","-i","2"]  
  

