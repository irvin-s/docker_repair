FROM centos:latest  
  
MAINTAINER Cameron Waldron <cameron.waldron@gmail.com>  
  
COPY scripts/ /root/scripts/  
ENV PATH /root/scripts:$PATH  
EXPOSE 80 443  
RUN yum -y update && \  
yum -y install epel-release && \  
yum -y install nginx git logrotate && \  
yum clean all && \  
/root/scripts/initialize  
CMD ["nginx","-g","daemon off;"]  

