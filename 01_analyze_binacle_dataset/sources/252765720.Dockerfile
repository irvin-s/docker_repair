FROM gliderlabs/alpine:3.4  
MAINTAINER VDuda  
  
RUN apk add --update alpine-sdk openssl-dev  
RUN apk add --no-cache git  
  
RUN git clone https://github.com/giltene/wrk2.git && cd wrk2 && make  
  
ENTRYPOINT ["wrk2/wrk"]  

