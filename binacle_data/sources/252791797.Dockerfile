FROM alpine:3.3  
MAINTAINER kenners <knutenners+damnsmall@gmail.com>  
  
LABEL arch=x86_64 \  
java.version="1.7.0_79" \  
java.vendor=OpenJDK \  
java.jvm=JRE \  
os=alpine  
  
ENV ALPINE_RELEASE=7.91.2.6.3-r1 \  
JAVA_HOME=/usr/lib/jvm/default-jvm \  
JAVA_VERSION=1.7.0_91 \  
LANG=C.UTF-8  
RUN set -ex \  
&& packages="openjdk7-jre-base=${ALPINE_RELEASE}" \  
&& apk add --update ${packages} \  
\  
&& rm -rf /var/cache/apk/*  
  
CMD ["/usr/bin/java", "-version"]  
  

