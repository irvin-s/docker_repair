FROM aguamala/centos-systemd:7  
MAINTAINER "gabo" <aguamala@deobieta.com>  
RUN yum -y install haproxy; yum clean all; systemctl enable haproxy.service  
EXPOSE 5000  
CMD ["/usr/sbin/init"]  

