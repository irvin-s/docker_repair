FROM gliderlabs/alpine:edge  
  
COPY run.sh /  
  
RUN apk add --no-cache gettext  
  
ENTRYPOINT ["/run.sh"]  

