FROM alpine:3.7  
ENV WS /upload-docs  
  
RUN apk add --no-cache \  
grep \  
curl \  
zip \  
doxygen \  
graphviz \  
ttf-ubuntu-font-family  
  
COPY upload-docs.sh /  
  
VOLUME $WS  
  
ENTRYPOINT ["/upload-docs.sh"]  

