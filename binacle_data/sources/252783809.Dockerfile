FROM alpine  
RUN apk update  
RUN apk add bash  
RUN apk add openssh  
RUN apk add git  
RUN apk add openjdk8  
RUN apk add apache-ant --update-cache \  
\--repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \  
\--allow-untrusted  
RUN apk add --update curl && \  
rm -rf /var/cache/apk/*  
ENTRYPOINT ["/usr/bin/curl"]  
ENV ANT_HOME /usr/share/java/apache-ant  
ENV PATH $PATH:$ANT_HOME/bin

