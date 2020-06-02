FROM learninglayers/base  
  
# Create data folders  
RUN mkdir -p /var/govitra-uploads/data  
RUN mkdir -p /var/govitra-uploads/temp  
RUN chmod -R 777 /var/govitra-uploads/  
  
# Initialize volume  
VOLUME /var/govitra-uploads/  

