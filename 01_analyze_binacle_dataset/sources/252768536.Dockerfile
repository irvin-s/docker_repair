  
FROM alpine:edge  
  
RUN \  
apk add --update nodejs && \  
rm -rf /var/cache/apk/*  
  
RUN mkdir -p /app  
  
WORKDIR /app  
  
VOLUME ["/app"]  
  
CMD ["node"]  
  

