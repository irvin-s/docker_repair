FROM ntodd/video-transcoding:latest  
MAINTAINER Donald Organ <dorgan@donaldorgan.com>  
  
WORKDIR /data  
RUN mkdir /scripts  
COPY scripts/transcode_all.sh /scripts/transcode.sh  
CMD ["/scripts/transcode.sh"]  

