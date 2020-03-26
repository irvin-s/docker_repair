FROM alpine:3.2  
MAINTAINER bortels@gmail.com  
RUN apk --update add socat  
USER nobody  
ENTRYPOINT ["socat"]  
CMD ["-h"]  

