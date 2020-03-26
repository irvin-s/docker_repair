FROM centos:centos6  
  
RUN yum update -y  
RUN yum install -y epel-release  
RUN yum install -y ganglia-web ganglia-gmetad  
  
ADD ganglia.conf /etc/httpd/conf.d/ganglia.conf  
ADD run.sh /usr/local/bin/run.sh  
  
VOLUME /etc/ganglia/  
VOLUME /var/lib/ganglia/rrds/  
EXPOSE 80  
CMD ["/usr/local/bin/run.sh"]  

