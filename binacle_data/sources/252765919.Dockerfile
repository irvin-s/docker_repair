FROM ubuntu:xenial  
MAINTAINER Rodrigo de la Fuente <rodrigo@delafuente.email>  
  
LABEL Description="Ubuntu container to be used as a Jenkins agent " \  
Vendor="ACME Products" \  
Version="1.0"  
  
USER root  
  
RUN set -e; \  
mkdir -p /var/run/sshd; \  
apt update; \  
apt full-upgrade -y; \  
apt install -y build-essential \  
git \  
openssh-server \  
openjdk-8-jdk \  
python \  
python-mock \  
python-nose \  
python-coverage \  
pylint \  
maven; \  
apt autoremove; \  
apt clean; \  
/usr/bin/ssh-keygen -A; \  
useradd -m -d /home/jenkins -s /bin/sh jenkins; \  
echo 'jenkins:jenkins' | chpasswd;  
  
EXPOSE 22  
  
CMD ["/usr/sbin/sshd", "-D"]  

