FROM golang:1.8.3-alpine  
MAINTAINER Dyson woo <mr5.simple@gmail.com>  
RUN apk add --no-cache make git && \  
cd && git clone https://github.com/getqujing/qtunnel.git qtunnel && \  
cd qtunnel && make && \  
mv bin/qtunnel /usr/bin && \  
cd .. && rm -rf qtunnel && \  
apk del make git  
COPY entrypoint.sh /usr/bin/qtunnel-entrypoint.sh  
RUN chmod +x /usr/bin/qtunnel-entrypoint.sh  
  
ENTRYPOINT ["qtunnel-entrypoint.sh"]  
EXPOSE 35838  

