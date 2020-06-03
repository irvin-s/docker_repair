FROM edrans/centos6  
  
MAINTAINER Nicolás de la Torre <ntorre@edrans.com>  
  
RUN yum install beanstalkd -y && yum clean all -y  
  
EXPOSE 11300  
ENTRYPOINT ["usr/bin/beanstalkd"]  
CMD ["-u", "nobody"]  

