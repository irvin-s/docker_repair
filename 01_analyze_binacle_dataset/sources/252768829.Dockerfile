FROM alpine  
  
RUN apk update && apk add netcat-openbsd python curl wget  
  
COPY shell.sh /tmp/shell.sh  
CMD /bin/sh /tmp/shell.sh  

