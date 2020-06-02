FROM centos:latest  
MAINTAINER dayreiner  
  
RUN yum makecache fast && yum -y update && yum clean all && yum history new \  
&& yum -y install bzip2 fontconfig git vim \  
&& curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - \  
&& yum -y install nodejs \  
&& mkdir -p /root/.ssh && chmod 700 /root/.ssh \  
&& touch /root/.ssh/known_hosts \  
&& ssh-keyscan -H github.com >> /root/.ssh/known_hosts \  
&& chmod 600 /root/.ssh/known_hosts  
  
WORKDIR /app  
EXPOSE 3000  
ENTRYPOINT ["npm"]  
CMD ["start"]  

