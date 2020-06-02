FROM adorsys/alpine-base:3.5  
MAINTAINER https://github.com/adorsys/dockerhub-openjdk-jre-base  
  
ENV JAVA_HOME /usr/lib/jvm/default-jvm  
# limit java processes to 128M heap by default  
ENV JAVA_TOOL_OPTIONS -Xmx128M  
  
RUN apk -q --no-cache add openjdk8-jre  

