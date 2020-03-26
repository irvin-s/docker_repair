FROM drmurx/sensu:1.3  
COPY install-deps.sh /usr/local/bin  
  
RUN /usr/local/bin/install-deps.sh  
  
CMD ["server"]  

