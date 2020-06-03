FROM centos:7  
WORKDIR /var/repo  
  
RUN yum -y install \  
createrepo \  
perl \  
yum-utils \  
&& yum clean all \  
&& rm -rf /var/cache/yum  
  
COPY entrypoint.sh /  
RUN chmod +x /entrypoint.sh  
  
ENTRYPOINT [ "/entrypoint.sh" ]  

