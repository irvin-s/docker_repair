FROM alpine:3.4  
RUN apk add --no-cache \  
bash \  
openssh \  
socat \  
&& rm -rf /var/cache/apk/*  
  
COPY run.sh /run.sh  
  
ENV SOCKET_DIR /.ssh-agent  
ENV SSH_AUTH_SOCK ${SOCKET_DIR}/socket  
ENV SSH_AUTH_PROXY_SOCK ${SOCKET_DIR}/proxy-socket  
  
VOLUME ${SOCKET_DIR}  
  
ENTRYPOINT ["/run.sh"]  
  
CMD ["ssh-agent"]  

