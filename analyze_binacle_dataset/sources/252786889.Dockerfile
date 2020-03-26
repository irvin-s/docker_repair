FROM learninglayers/base  
  
RUN mkdir -p /var/achminup-uploads/data/videos/  
RUN mkdir -p /var/achminup-uploads/data/thumbnails/  
  
RUN chmod -R 777 /var/achminup-uploads/  
  
VOLUME /var/achminup-uploads/  
  

