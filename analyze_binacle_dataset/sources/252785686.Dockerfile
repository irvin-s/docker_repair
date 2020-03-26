FROM alpine:edge  
  
ARG BUILD_DATE  
ARG VCS_REF  
  
LABEL org.label-schema.build-date=$BUILD_DATE\  
org.label-schema.vcs-url="https://github.com/comodal/alpine-stunnel.git"\  
org.label-schema.vcs-ref=$VCS_REF\  
org.label-schema.name="Stunnel Alpine:edge Image"\  
org.label-schema.usage="https://github.com/comodal/alpine-stunnel#docker-run"\  
org.label-schema.schema-version="1.0.0-rc.1"  
  
RUN apk add --no-cache stunnel  
  
ENTRYPOINT ["/usr/bin/stunnel"]  
CMD ["/etc/stunnel/stunnel.conf"]  

