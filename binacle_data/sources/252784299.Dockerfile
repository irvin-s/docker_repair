FROM alpine  
MAINTAINER Jarrett Irons <jarrett.irons@gmail.com>  
  
ENV PORT 8080  
ENV RESPONSE_CODE 200  
ENV RESPONSE_MESSAGE OK  
  
RUN apk update \  
&& apk add --no-cache netcat-openbsd gettext\  
&& rm -rf /var/cache/apk/*  
  
EXPOSE $PORT  
COPY nc.template /tmp/nc.template  
  
CMD envsubst < /tmp/nc.template > /tmp/nc.txt && \  
while true; do cat /tmp/nc.txt | nc -l ${PORT}; done  

