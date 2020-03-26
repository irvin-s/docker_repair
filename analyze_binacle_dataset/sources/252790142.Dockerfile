# Pull base image  
FROM elasticsearch:2  
# /usr/share/elasticsearch/bin is in PATH  
RUN plugin install -b mapper-attachments  

