FROM alpine  
MAINTAINER Anastas Dancha <anapsix@random.io>  
RUN apk upgrade --update && \  
apk add g++ make git && \  
cd /tmp && git clone http://github.com/klange/nyancat.git && \  
cd /tmp/nyancat && make && cp ./src/nyancat /usr/local/bin/ && cd / && \  
rm -rf /tmp/nyancat && \  
apk del --purge g++ make git  
CMD /usr/local/bin/nyancat  

