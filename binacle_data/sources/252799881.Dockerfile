FROM alpine:latest  
  
LABEL maintainer="carlos@digitalr00ts.com"  
  
ENV LANG=en_US.UTF-8 \  
LANGUAGE=en_US:en \  
LC_ALL=en_US.UTF-8 \  
unicode=YES  
  
RUN cd && set -ex && \  
apk --update upgrade && \  
apk add tini && \  
rm -rf -- /var/cache/apk/* /var/lib/apk/* /etc/apk/cache/* /root/.cache  
  
ENTRYPOINT ["/sbin/tini", "-g", "--"]  

