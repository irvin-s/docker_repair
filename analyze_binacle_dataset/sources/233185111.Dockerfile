FROM centos:latest
MAINTAINER arnabsinha4u@gmail.com 
RUN yum -y install epel-release && yum -y install openssh openssh-server openssh-clients ansible && yum clean all
LABEL "Running"="docker run -d -P image_name:latest"

RUN mkdir /var/run/sshd ; \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo "IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config && \
    systemctl enable sshd ; \
    echo 'root:password' | chpasswd ; \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "StrictModes no" >> /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    mkdir -p /root/.ssh && \
    touch /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa

EXPOSE 22

CMD /usr/bin/ssh-keygen -A ; /usr/sbin/sshd -D
