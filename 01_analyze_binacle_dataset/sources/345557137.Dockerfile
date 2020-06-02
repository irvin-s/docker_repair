FROM centos:centos7
MAINTAINER Jose De la Rosa "https://github.com/jose-delarosa"

# Update and install required packages (so we can ssh into it)
RUN yum -y update; yum -y install openssh-server openssh-clients

# Set password
RUN yum -y install passwd; echo 'root:password' | chpasswd

# Install required packages to make DSU execute properly
RUN yum -y install wget perl

# Add repo and install
RUN wget -q -O - http://linux.dell.com/repo/hardware/dsu/bootstrap.cgi | bash; \
    yum -y install dell-system-update

# Clean things up
RUN yum clean all

# Set keys
RUN mkdir /var/run/sshd; ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key; \
    ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N j3abnYQ9ju7g

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
