FROM jeanblanchard/java:jre-8  
LABEL MAINTAINER Chevdor <chevdor@gmail.com>  
LABEL version="1.11.12"  
  
ENV NRSVersion=1.11.12  
RUN \  
apk update && \  
apk add wget gpgme && \  
mkdir /nxt-boot && \  
mkdir /nxt && \  
cd /  
  
ADD scripts /nxt-boot/scripts  
  
VOLUME /nxt  
WORKDIR /nxt-boot  
  
ENV NXTNET test  
  
COPY ./nxt-main.properties /nxt-boot/conf/  
COPY ./nxt-test.properties /nxt-boot/conf/  
COPY ./init-nxt.sh /nxt-boot/  
  
EXPOSE 6876 7876 6874 7874  
CMD ["/nxt-boot/init-nxt.sh", "/bin/sh"]

