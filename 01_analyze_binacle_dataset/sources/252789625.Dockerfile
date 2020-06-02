FROM ubuntu:xenial  
ENV TIMEZONE="Asia/Shanghai" \  
PRODUCT="jre" \  
JAVA_HOME="/usr/lib/java"  
COPY prepare.sh /usr/local/bin  
RUN prepare.sh  

