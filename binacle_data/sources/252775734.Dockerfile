FROM alpine:3.7  
RUN apk --update add rsync=3.1.3-r0 \  
&& rm -rf /var/cache/apk/*  
  
CMD /bin/sh  

