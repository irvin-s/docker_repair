FROM golang:alpine as builder  
RUN apk add --update git  
RUN go get github.com/chenhw2/changeip-ddns-cli  
  
FROM chenhw2/alpine:base  
MAINTAINER CHENHW2 <https://github.com/chenhw2>  
  
# /usr/bin/changeip-ddns-cli  
COPY \--from=builder /go/bin /usr/bin  
  
USER nobody  
  
ENV USERNAME=1234567890 \  
PASSWORD=abcdefghijklmn \  
DOMAIN=ddns.changeip.com \  
REDO=0  
CMD changeip-ddns-cli \  
\--username ${USERNAME} \  
\--password ${PASSWORD} \  
auto-update \  
\--domain ${DOMAIN} \  
\--redo ${REDO}  

