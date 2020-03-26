FROM amazonlinux:latest  
  
# Install C and wget  
RUN yum install gcc44 gcc-c++ libgcc44 cmake wget -y  
  
# Install node  
RUN curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -  
RUN yum install nodejs -y && npm install -g serverless  
  
WORKDIR /var/task  
  
CMD ["/bin/bash"]  

