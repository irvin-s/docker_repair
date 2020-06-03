FROM alpine:edge  
MAINTAINER Arno0x0x - https://twitter.com/arno0x0x  
  
ADD ./entry_point.sh /  
  
RUN apk update \  
&& apk upgrade \  
&& apk add socat \  
&& apk add --update-cache \  
\--repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \  
\--allow-untrusted --update tor \  
&& rm -rf /var/cache/apk/* \  
&& chmod +x /entry_point.sh  
  
ADD ./torrc /etc/tor/torrc  
  
EXPOSE 5000  
ENTRYPOINT ["/entry_point.sh"]

