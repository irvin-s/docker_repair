FROM centos:latest  
MAINTAINER github.com/blindly  
  
# Install HTTPD  
RUN yum install httpd mod_ssl -y  
  
# Install repo  
RUN rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm  
  
# Install MBstring  
RUN yum install mbstring php54w php54w-mysql php54w-mbstring -y  
  
# Install Mcrypt  
RUN yum install mcrypt php54w-mcrypt -y  
  
# Add HTTPD Conf  
ADD httpd.conf /etc/httpd/conf/httpd.conf  
  
EXPOSE 80  
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]  

