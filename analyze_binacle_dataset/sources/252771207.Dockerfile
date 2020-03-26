FROM centos:7  
MAINTAINER Aitor Martin <aitor@martinh.es>  
  
ENV HOME /root  
  
EXPOSE 80  
RUN yum update -y && yum install -y epel-release &&\  
yum install -y nginx  
  
ADD nginx.conf /etc/nginx/  
  
ADD entrypoint.sh /usr/local/bin/  
  
ENTRYPOINT ["entrypoint.sh"]  

