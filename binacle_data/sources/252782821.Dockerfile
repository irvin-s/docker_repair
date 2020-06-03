FROM ubuntu:14.04  
ADD couchdb-dump/ /couchdb-dump/  
RUN chmod u+x /couchdb-dump/couchdb-backup.sh  
RUN mkdir -p /dump  
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*  
  
ADD run.sh /run.sh  
RUN chmod u+x /run.sh  
  
ENV FILENAME dump.json  
ENV FROMHOST from.docker  
ENV FROMPORT 5984  
ENV FROMDB exampledb  
ENV TOHOST to.docker  
ENV TOPORT 5984  
ENV TODB exampledb  
  
CMD /run.sh  

