FROM dockerfile/java:oracle-java7  
MAINTAINER Martin Chalupa <chalimartines@gmail.com>  
  
#Base image doesn't start in root  
WORKDIR /  
  
RUN curl -LO http://apache.cs.utah.edu/pig/pig-0.14.0/pig-0.14.0.tar.gz  
RUN tar xzf pig-0.14.0.tar.gz  
  
ENV PATH $PATH:/pig-0.14.0/bin  
  
ADD run_pig.sh run_pig.sh  
RUN chmod +x /run_pig.sh  
  
ENTRYPOINT ["/run_pig.sh"]  

