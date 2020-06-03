FROM alpine:3.6  
  
RUN apk --no-cache --update add openssl  
  
COPY entrypoint.sh /  
  
CMD /entrypoint.sh  
  
VOLUME /ca /client /server /scratch  
  

