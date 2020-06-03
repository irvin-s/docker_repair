FROM arnaudpiroelle/base  
MAINTAINER Arnaud Piroelle "piroelle.arnaud@gmail.com"  
RUN apt-get update && apt-get install -y rsync  
  
COPY entrypoint.sh /opt/entrypoint.sh  
COPY rsync.sh /opt/rsync.sh  
  
VOLUME /rsync  
VOLUME /sync  
  
ENTRYPOINT ["/opt/entrypoint.sh"]  
CMD ["/opt/rsync.sh"]

