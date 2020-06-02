FROM openjdk:8-alpine  
MAINTAINER FROM changwenwen@126.com  
  
ENV JETTY_HOME /opt/jetty9.3.11  
RUN mkdir -p /opt && \  
apk add --no-cache --update-cache bash && \  
rm -rf /tmp/* /var/cache/apk/*  
ADD jetty9.3.11.tar.gz /opt  
  
WORKDIR $JETTY_HOME  
  
EXPOSE 8080  
COPY docker-entrypoint.sh /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  

