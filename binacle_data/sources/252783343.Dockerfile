FROM centos:6  
RUN yum -y update; yum -y install epel-release  
RUN yum -y install \  
initscripts \  
PyYAML \  
libyaml \  
python-babel \  
python-crypto \  
python-crypto2.6 \  
python-httplib2 \  
python-jinja2 \  
python-keyczar \  
python-markupsafe \  
python-paramiko \  
python-pyasn1 \  
python-setuptools \  
python-simplejson \  
python-six \  
python-pip \  
libffi-devel \  
python-devel \  
openssl-devel \  
sshpass \  
curl \  
gcc \  
&& yum clean all  
  
RUN mv /etc/init/serial.conf /etc/init/serial.conf.disabled; \  
mv /etc/init/tty.conf /etc/init/tty.conf.disabled; \  
mv /etc/init/start-ttys.conf /etc/init/start-ttys.conf.disabled  
  
RUN pip install setuptools==18.5  
RUN pip install ansible  
  
RUN pip install cffi==1.7  
RUN pip install ansible-lint  
  
RUN curl -fsSL https://goss.rocks/install | sh  
  
WORKDIR /ansible  
  
CMD ["/sbin/init"]  

