FROM alpine:latest  
  
RUN apk add --no-cache tvheadend  
  
CMD ["/usr/bin/tvheadend", "--firstrun"]  
  
EXPOSE 9981 9982  
VOLUME ["/root/.hts/tvheadend"]  

