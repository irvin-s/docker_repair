#First docker file  
FROM centos:6  
COPY transfer.txt /  
ADD /files /files  
ENV HOME /files  
RUN yum update -y  
RUN yum install -y httpd iputils  
CMD service httpd start  

