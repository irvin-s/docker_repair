FROM gliderlabs/alpine:edge  
  
RUN set -ex && \  
apk add --no-cache curl ca-certificates  
  
COPY run.sh /  
  
CMD ["/run.sh"]  

