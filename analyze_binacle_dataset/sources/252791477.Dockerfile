FROM alpine:latest  
MAINTAINER dali.kilani@gmail.com  
RUN apk --update add socat  
USER nobody  
EXPOSE 11022  
ENTRYPOINT ["socat","TCP4-LISTEN:11022,fork,su=nobody"]  
CMD "TCP4:$SSH_DEST_HOST:$SSH_DEST_PORT"  

