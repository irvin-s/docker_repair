FROM centos:latest  
  
ENV PATH="/usr/local/bin:$PATH"  
ENV LANGUAGE en_US.UTF-8  
ENV LANG en_US.UTF-8  
WORKDIR /home/  
  
RUN yum -y install \  
bzip2 \  
curl \  
wget \  
which \  
&& yum -y install https://centos7.iuscommunity.org/ius-release.rpm \  
&& yum -y remove git \  
&& yum -y install git2u-core.x86_64 \  
python36u \  
python36u-pip \  
python36u-devel \  
&& pip3.6 install pipenv \  
&& yum -y update \  
&& yum -y autoremove \  
&& yum clean all \  
&& rm -rf /var/cache/yum  
  
COPY start.sh /etc/profile.d/  
  
EXPOSE 8888  
CMD /usr/bin/bash  

