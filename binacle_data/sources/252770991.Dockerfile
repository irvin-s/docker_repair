FROM aguamala/ansible:2.2.0  
MAINTAINER "gabo" <aguamala@deobieta.com>  
  
RUN echo "===> Installing git..." && \  
yum -y install git  
  
RUN echo "===> ssh-keyscan" && \  
ssh-keyscan bitbucket.org > /etc/ssh/ssh_known_hosts && \  
ssh-keyscan github.com >> /etc/ssh/ssh_known_hosts  
  
CMD ["ansible-galaxy"]  

