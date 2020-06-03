FROM centos:centos7  
  
RUN yum -y update && \  
yum -y install sudo  
  
RUN groupadd sudo  
RUN useradd -m -G sudo docker  
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers  
  
USER docker  
  
CMD ["/bin/bash"]  

