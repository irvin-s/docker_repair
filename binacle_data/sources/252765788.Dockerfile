# bbcp command  
#  
# VERSION 1.0  
# use centos base image  
FROM centos:centos6  
  
# specify the maintainer  
MAINTAINER Quan Nguyen, mr.quan.nguyen@gmail.com  
  
EXPOSE 5031:5040  
# Install required packages  
RUN yum install -y wget  
RUN yum install -y openssh-clients  
  
# general yum cleanup  
RUN yum install -y yum-utils  
RUN package-cleanup --dupes; package-cleanup --cleandupes; yum clean -y all  
  
# Download binary  
RUN wget http://www.slac.stanford.edu/~abh/bbcp/bin/amd64_rhel60/bbcp -P /bin  
RUN chmod +x /bin/bbcp  
  
VOLUME /home  
WORKDIR /home  
ENV HOME /home  
  
ENTRYPOINT [ "/bin/bbcp" ]  

