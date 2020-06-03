FROM "centos:7"  
COPY install /  
RUN /install  
COPY ./kudu-start /  
COPY ./entrypoint /  
  
ENTRYPOINT ["/entrypoint"]  

