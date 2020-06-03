FROM alpine:latest  
RUN apk add --no-cache darkhttpd && mkdir -p /data  
VOLUME /data  
CMD ["darkhttpd", "/data"]  
EXPOSE 80  

