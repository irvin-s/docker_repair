FROM alpine:edge  
  
ENV PASSWORD "emptyPassword"  
ENV EXIT_NODES ""  
EXPOSE 9050 9051  
ADD ./entrypoint.sh /entrypoint.sh  
ADD ./torrc /tmp/torrc  
  
RUN apk update && \  
apk upgrade && \  
apk add --update-cache \  
\--repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \  
\--allow-untrusted tor && \  
rm /var/cache/apk/* && \  
chmod a+w /tmp/torrc  
  
USER tor  
  
CMD /entrypoint.sh  

