# This container doesn't do anything except run the sshd daemon. It can be used
# as a contained environment accessed remotely to retrieve or drop files for
# archival.
FROM centos:centos7
MAINTAINER Jose De la Rosa "https://github.com/jose-delarosa"

# User we'll use to login with
ENV USER jose

# Update and install required packages
RUN yum -y update && yum -y install openssh-server rsync && yum clean all

# Create needed SSH keys
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

# Setup for certificate login ONLY
RUN sed -i -e 's/#RSAAuthentication yes/RSAAuthentication yes/' \
           -e 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' \
           -e 's/#PermitRootLogin yes/PermitRootLogin no/' \
           -e 's/PasswordAuthentication yes/PasswordAuthentication no/' \
           -e 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' \
           /etc/ssh/sshd_config

RUN useradd -m $USER; mkdir /share1

CMD ["/usr/sbin/sshd", "-D"]
