FROM restic/restic  
  
RUN set -x \  
&& apk add --no-cache \  
ca-certificates \  
iproute2  
  
add entry.sh /entry.sh  
  
ENV HOME=/root  
  
ENTRYPOINT ["/bin/sh", "/entry.sh"]  
  

