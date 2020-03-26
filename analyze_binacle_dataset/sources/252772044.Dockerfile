FROM cassandra:latest  
  
MAINTAINER Audris Mockus <audris@utk.edu>  
  
RUN apt-get update && apt-get install -y \  
curl \  
pkg-config \  
python3 \  
python3-pip \  
vim \  
sssd \  
openssh-server \  
openssh-client \  
libpam-sss \  
sssd-tools \  
&& \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
#install ldap authentication to use utk's ldap  
COPY eecsCA_v3.crt /etc/ssl/  
COPY sssd.conf /etc/sssd/  
COPY common* /etc/pam.d/  
RUN chmod 0600 /etc/sssd/sssd.conf /etc/pam.d/common*  
RUN mkdir -p /var/run/sshd  
RUN chmod 0755 /var/run/sshd  
RUN mkdir -p /var/run/sshd  
RUN chmod 0755 /var/run/sshd  
  
RUN pip3 install cassandra-driver  
  

