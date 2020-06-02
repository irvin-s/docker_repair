#Based upon Adam Crump's amkor/docker-salesforce image  
FROM alpine  
MAINTAINER Ben Edwards <ben@edwards.nz>  
RUN apk update  
RUN apk add bash git openssh  
RUN apk add openjdk8  
RUN apk add apache-ant --update-cache \  
\--repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \  
\--allow-untrusted  
RUN apk add --update curl && \  
rm -rf /var/cache/apk/*  
RUN apk add --update nodejs nodejs-npm  
  
ENTRYPOINT ["/usr/bin/curl"]  
  
ENV ANT_HOME /usr/share/java/apache-ant  
ENV PATH $PATH:$ANT_HOME/bin  

