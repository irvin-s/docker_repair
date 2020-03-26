FROM blalor/centos  
  
ADD . /tmp/cloudstack-simulator  
  
WORKDIR /tmp/cloudstack-simulator  
  
RUN /tmp/cloudstack-simulator/bootstrap.sh  
  
CMD ["/usr/bin/supervisord"]  
  
EXPOSE 3306 5672 8080

