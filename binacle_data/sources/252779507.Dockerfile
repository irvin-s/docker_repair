FROM centos:7  
RUN yum -y install epel-release; \  
yum update -y && \  
yum install -y \  
supervisor && \  
yum clean all;  
  
RUN mkdir -p /etc/supervisor/conf.d  
ADD supervisord.base.conf /etc/supervisor/conf.d/supervisor.base.conf  
ADD supervisord.conf /etc/supervisor/supervisord.conf  
  
CMD ["supervisord","-n", "-c", "/etc/supervisor/supervisord.conf"]

