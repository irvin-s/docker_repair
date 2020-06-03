FROM convox/fakes3  
  
ENV AWS_ACCESS access  
ENV AWS_SECRET secret  
ENV AWS_BUCKET bucket  
  
ENV BOTO_CALLING_FORMAT boto.s3.connection.OrdinaryCallingFormat  
  
ADD bin/fakes3-convox /opt/fakes3/bin/fakes3-convox  
CMD ["/opt/fakes3/bin/fakes3-convox"]  

