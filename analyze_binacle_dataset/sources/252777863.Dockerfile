#  
#  
#  
FROM sequenceiq/hadoop-docker:2.5.2  
MAINTAINER Ivan Pedrazas  
  
RUN curl -LO http://mirror.vorboss.net/apache/pig/pig-0.14.0/pig-0.14.0.tar.gz  
RUN tar xzf pig-0.14.0.tar.gz  
  
ENV PATH $PATH:/pig-0.14.0/bin  
  
  

