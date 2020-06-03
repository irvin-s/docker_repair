FROM centos:centos6  
  
RUN yum -y groupinstall "Development Tools" \  
&& yum clean packages  
RUN yum -y install \  
cmake \  
git \  
python \  
ssh \  
sudo \  
&& yum clean packages  
  
COPY sudoers /etc/sudoers  
RUN chmod 0660 /etc/sudoers  
  
RUN useradd -m -G wheel buzzy  
  
RUN mkdir /home/buzzy/.ssh \  
&& chown buzzy:buzzy /home/buzzy/.ssh \  
&& chmod 0700 /home/buzzy/.ssh \  
&& ssh-keyscan github.com >> /home/buzzy/.ssh/known_hosts \  
&& chown buzzy:buzzy /home/buzzy/.ssh/known_hosts \  
&& chmod 0600 /home/buzzy/.ssh/known_hosts  
  
USER buzzy  
ENV HOME /home/buzzy  
WORKDIR /home/buzzy  
CMD ["/bin/bash"]  

