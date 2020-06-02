FROM alpine:latest  
  
RUN apk add --no-cache tar  
  
ENTRYPOINT ["tar"]  

