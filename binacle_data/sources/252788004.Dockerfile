FROM alpine:3.5  
MAINTAINER Christian Musa <christianmusa@gmail.com>  
  
RUN apk update && apk add fail2ban && mkdir /var/run/fail2ban  
  
CMD ["-f", "start"]  
ENTRYPOINT ["/usr/bin/fail2ban-client"]  

