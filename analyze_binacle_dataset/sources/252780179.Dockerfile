FROM centos  
RUN yum -y update  
ADD script.sh /tmp  
RUN chmod +x /tmp/script.sh  

