FROM gliderlabs/alpine:latest  
  
RUN apk add --no-cache curl jq bash  
  
CMD ["/bin/sh"]  

