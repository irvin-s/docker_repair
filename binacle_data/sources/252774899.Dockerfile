FROM ubuntu:xenial  
  
EXPOSE 11300  
RUN apt-get update  
RUN apt-get install -y beanstalkd=1.10-3  
  
VOLUME ["/data"]  
  
CMD ["beanstalkd", "-b", "/data", "-p", "11300"]  

