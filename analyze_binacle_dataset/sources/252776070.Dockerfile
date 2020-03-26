FROM alpine  
ENV REPO "none"  
ADD run.sh /run.sh  
ADD repo.txt /repo.txt  
RUN chmod a+x /run.sh && chmod a+x /repo.txt  
CMD ["/bin/sh", "/run.sh", "lookup"]  

