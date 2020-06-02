FROM alpine:3.7  
LABEL maintainer="chris.rohrer@ubuntunet.net"  
  
WORKDIR /radius  
  
RUN apk update && apk upgrade && \  
apk add --update freeradius freeradius-radclient && \  
rm /var/cache/apk/*  
  
EXPOSE 1812/udp 1813/udp  
  
CMD ["radiusd", "-sfl", "stdout"]

