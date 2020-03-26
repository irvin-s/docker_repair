FROM ubuntu:17.04  
ADD clean_log /usr/bin/clean_log  
RUN chmod +x /usr/bin/clean_log  
ENTRYPOINT ["/usr/bin/clean_log"]  
CMD ["7"]  

