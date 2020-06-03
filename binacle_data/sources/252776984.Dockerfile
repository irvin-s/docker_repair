FROM centos:7  
ENV container docker  
RUN yum update -y  
RUN yum install --assumeyes python bash openssh-client curl net-tools  
COPY server.py /server.py  
RUN useradd -s /bin/bash valjean  
USER valjean  
  
EXPOSE 8080  
ENTRYPOINT ["/server.py"]  

