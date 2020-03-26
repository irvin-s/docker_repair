FROM alpine  
  
RUN apk add --update --no-cache socat \  
&& rm -rf /var/cache/apk/* \  
/tmp/* \  
/var/tmp/*  
  
ENV LISTEN_PORT 1081  
ENV FORWARD_TO some.host.or.ip:1080  
EXPOSE ${LISTEN_PORT}  
  
ADD ./socat.sh /  
CMD ["/socat.sh"]  

