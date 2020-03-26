FROM alpine  
  
# Create 3 directories, eache containing file1  
RUN mkdir -p /test  
RUN ln -s /toto /test/toto  
  
# Remove opaque-dir, re-create it  
RUN rm /test/toto  

