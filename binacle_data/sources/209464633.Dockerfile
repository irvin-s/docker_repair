# CentOS 7 with sshd
FROM centos:7

# Author
MAINTAINER Max Huang <sakana@cycu.org.tw>

# Install Enterprise Repository
RUN yum install epel-release -y

# Install openssh-server
RUN yum -y install openssh-server

# Create SSH key
RUN ssh-keygen -t rsa  -f /etc/ssh/ssh_host_rsa_key -N ""
RUN ssh-keygen -t ecdsa  -f /etc/ssh/ssh_host_ecdsa_key -N ""
RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""

# Install passwd package
RUN yum -y install passwd

# Modify root passwd
RUN echo "root:newRootpass"|chpasswd

#expose ports
EXPOSE 22

# Define default command.
CMD ["/usr/sbin/sshd", "-D"]
