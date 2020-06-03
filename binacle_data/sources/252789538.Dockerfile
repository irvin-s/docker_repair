FROM alpine:edge  
  
ARG BUILD_DATE  
ARG VCS_REF  
  
LABEL org.label-schema.build-date=$BUILD_DATE \  
org.label-schema.vcs-ref=$VCS_REF \  
org.label-schema.schema-version="1.0" \  
org.label-schema.name="skilld-varnish" \  
org.label-schema.description="Skilld varnish" \  
org.label-schema.vcs-url="https://github.com/skilld-labs/skilld-varnish" \  
maintainer="Andy Postnikov <andypost@ya.ru>"  
  
ENV VARNISH_BACKEND_HOST nginx  
ENV VARNISH_BACKEND_PORT 80  
ENV VARNISH_MEMORY 100M  
ENV VARNISH_BACKEND_FIRST_BYTE_TIMEOUT 300s  
ENV VARNISH_BACKEND_CONNECT_TIMEOUT 5s  
ENV VARNISH_BACKEND_BETWEEN_BYTES_TIMEOUT 2s  
ENV VARNISH_ERRORS_TTL 10m  
ENV VARNISH_GRACE 6h  
ENV VARNISH_SUBNET 172.16.0.0/12  
ENV VARNISH_SECRET_FILE none  
ENV VARNISH_COOKIE_REGEXP SESS[a-z0-9]+|SSESS[a-z0-9]+|NO_CACHE  
  
RUN apk add --no-cache varnish  
  
EXPOSE 80  
ADD start.sh /start.sh  
ADD default.vcl /etc/varnish/default.vcl  
CMD ["/start.sh"]  

