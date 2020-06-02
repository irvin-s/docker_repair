FROM gliderlabs/alpine  
RUN apk add --no-cache nodejs  
ENTRYPOINT ["node"]  

