FROM alpine  
  
RUN apk --no-cache add taskd  
  
ENV TASKDDATA=/var/taskd  
VOLUME /var/taskd  
  
CMD ["taskd", "--version"]  

