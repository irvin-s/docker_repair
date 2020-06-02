FROM centos:centos7  
MAINTAINER "Taygun Agiali" <taygun.agiali@eaudeweb.ro>  
  
RUN \  
yum -y updateinfo && \  
yum install -y epel-release && \  
yum --enablerepo=epel -y install Pound && \  
yum clean all  
  
COPY run.sh /bin/run.sh  
RUN chmod a+x /bin/run.sh  
COPY reload.sh /bin/reload  
RUN chmod a+x /bin/reload  
RUN mkdir -p /etc/pound  
CMD /bin/run.sh  

