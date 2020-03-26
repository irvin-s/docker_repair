FROM busybox:latest  
MAINTAINER Adrian Haasler García <dev@adrianhaasler.com>  
  
# Declare volume  
VOLUME /data/stash  
  
# Assign proper ownership and permissions  
CMD chown 782:root /data/stash \  
&& chmod 770 /data/stash  

