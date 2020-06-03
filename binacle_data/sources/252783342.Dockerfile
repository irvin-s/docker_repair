FROM amazonlinux:1  
RUN yum -y update && yum -y install \  
initscripts \  
python27-pip \  
openssl \  
curl \  
epel-release \  
&& yum clean all \  
&& yum-config-manager --enable epel > /dev/null 2>&1  
  
RUN mv /etc/init/serial.conf /etc/init/serial.conf.disabled; \  
mv /etc/init/tty.conf /etc/init/tty.conf.disabled; \  
mv /etc/init/start-ttys.conf /etc/init/start-ttys.conf.disabled  
  
RUN pip install ansible ansible-lint  
RUN curl -fsSL https://goss.rocks/install | sh  
  
WORKDIR /ansible  
  
CMD ["/sbin/init"]  

