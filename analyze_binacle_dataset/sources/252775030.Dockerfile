FROM ubuntu:16.04  
COPY bin/ /usr/local/bin/  
  
ENV PATH "/usr/local/bin:$PATH"  

