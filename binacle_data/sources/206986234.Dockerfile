FROM centos:centos7

MAINTAINER "Toshiki Inami <t-inami@arukas.io>"

# Set username/password login as a default
# public authentication will be enabled with AUTHORIZED_KEY ENV
ENV ROOT_PWD default
ENV AUTHORIZED_KEY none

# Install openssh, openssh-clients, openssh-server
# Generate ssh key without passphrases
# Configure sshd.conf
# Then cleanup
RUN yum -y install openssh openssh-clients openssh-server && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -A && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config && \
    sed -i 's/session\s*required\s*pam_loginuid.so/session    optional     pam_loginuid.so/g' /etc/pam.d/sshd && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum/*

# Make start.sh excutable
COPY start.sh /start.sh

# Expose 22 for SSH access
EXPOSE 22

# Start supervisord to controll processes
CMD ["./start.sh", "-bash"]
