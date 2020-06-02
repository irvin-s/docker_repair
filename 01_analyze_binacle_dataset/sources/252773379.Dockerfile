FROM centos:centos7  
  
RUN yum update -y && \  
yum install -y epel-release && \  
yum install -y iperf3 && \  
yum clean all  
  
EXPOSE 5201  
ENTRYPOINT ["iperf3"]  

