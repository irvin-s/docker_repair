FROM alteroo/plone-base:latest  
MAINTAINER David Bain <david@alteroo.com>  
  
  
# default values are set upstream  
# ENV PASSWORD secret  
# ENV MAJORVERSION 4.3  
# ENV MINORVERSION 4.3.4  
# ENV TARGETDIR /opt/plone  
# ENV INSTANCENAME app  
# ENV INSTANCEDIR $TARGETDIR/$INSTANCENAME  
ADD zeo.cfg $INSTANCEDIR/  
WORKDIR $INSTANCEDIR  
# /opt/plone/app/var/blobstorage  
VOLUME $INSTANCEDIR/var/blobstorage  
# /opt/plone/app/var/filestorage  
VOLUME $INSTANCEDIR/var/filestorage  
RUN bin/buildout -c zeo.cfg  
CMD bin/zeoserver fg  
  
EXPOSE 8100  

