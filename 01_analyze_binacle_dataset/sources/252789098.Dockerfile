FROM ubuntu:16.04  
ENV PATH=/opt/anaconda/bin:$PATH  
  
COPY install.sh /usr/bin/install.sh  
  
RUN chmod +x /usr/bin/install.sh && bash install.sh  
  
CMD ["bash", "-c", "/usr/bin/launcher.sh"]  

