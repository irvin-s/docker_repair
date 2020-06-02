FROM learninglayers/base  
  
COPY setup.sh /setup.sh  
RUN /bin/bash /setup.sh  
  
EXPOSE 8080  
CMD ["/go/bin/go-video-transcoder"]  
  

