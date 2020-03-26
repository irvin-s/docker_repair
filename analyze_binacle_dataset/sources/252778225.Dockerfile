FROM centos/mongodb-32-centos7  
  
USER root  
  
ENV BACKUP_KEEP=2 BACKUP_MINUTE=0 BACKUP_HOUR=*  
  
RUN yum -y install epel-release && yum update -y  
RUN yum -y install python \  
python-devel \  
python-pip \  
mercurial && yum clean all  
#yum clean all  
# Install dev cron  
RUN pip install -e hg+https://bitbucket.org/dbenamy/devcron#egg=devcron  
  
RUN mkdir -p /opt/app-root/src && chown -R 1001 /opt/app-root/src  
  
WORKDIR /opt/app-root/src  
  
ADD ./bin ./bin  
RUN chmod -R 777 /opt/app-root/src  
  
USER 1001  
CMD ./bin/run.sh  

