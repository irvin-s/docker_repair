FROM centos:7  
ADD repo/hdp.repo /etc/yum.repos.d/HDP.repo  
ADD repo/hdp-utils.repo /etc/yum.repos.d/HDP-utils.repo  
  
RUN yum install -y java-1.8.0 hive which  
  
ENV JAVA_HOME /usr/lib/jvm/jre  
  
ENTRYPOINT ["/usr/bin/beeline"]

