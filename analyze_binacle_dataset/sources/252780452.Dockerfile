FROM alpine:3.6  
RUN addgroup alpine && adduser -G alpine -s /bin/sh -D alpine \  
&& apk add --update git openssh \  
&& rm -rf /var/cache/apk/* \  
&& mkdir /git \  
&& chown alpine:alpine /git  
  
USER alpine  
  
WORKDIR /git  
  
ENTRYPOINT ["/usr/bin/git"]  
CMD ["-version"]  

