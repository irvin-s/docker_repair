FROM centos:7  
LABEL maintainer="Chris Short <chris@chrisshort.net>"  
  
COPY requirements.txt /root/requirements.txt  
  
RUN set -x \  
&& yum -y install epel-release gcc \  
&& yum clean all \  
&& rm -rf /var/cache/yum  
RUN set -x \  
&& yum -y install python-pip python-devel \  
&& yum clean all \  
&& rm -rf /var/cache/yum  
RUN set -x \  
&& pip install --upgrade pip  
RUN set -x \  
&& pip install -r /root/requirements.txt  
  
ENTRYPOINT [ "/bin/bash" ]  
  

