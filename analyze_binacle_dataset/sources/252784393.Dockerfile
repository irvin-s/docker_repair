FROM centos:6  
MAINTAINER bitscoid <admin@bits.co.id>  
  
RUN \  
yum update -y && \  
yum upgrade -y \  
yum install nano zip unzip wget curl git -y \  
  
# Set environment variables.  
ENV HOME /root  
  
# Define working directory.  
WORKDIR /root  
  
# Define default command.  
CMD ["bash"]  

