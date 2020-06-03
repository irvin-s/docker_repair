FROM centos:latest

# build with:  sudo docker build --tag ssh-centos .
# run with:    sudo docker run -d ssh-centos

ARG user=student
ARG pass=alta3
ARG gh_user=alta3-student1

RUN yum -y update                                                                                             && \
    yum install -y epel-release                                                                               && \
    yum install -y jq curl sudo vim openssh-server man less python git                                        && \ 
    mkdir /var/run/sshd                                                                                       && \
    echo "AllowAgentForwarding yes" >> /etc/ssh/sshd_config                                                   

# create user, set password, make passwordless sudoer, add authorized key
RUN useradd --create-home --shell /bin/bash ${user}                                                           && \ 
    install --directory --owner=${user} --group=${user} /home/${user}/.ssh                                    && \ 
    echo "${user}:${pass}" | chpasswd                                                                         && \ 
    echo "export LC_ALL=C" >> /home/${user}/.bashrc                                                           && \
    echo "${user}	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers                                              && \
    curl -s https://api.github.com/users/${gh_user}/keys | jq -r '.[] | .key' > /home/${user}/.ssh/authorized_keys

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

# allow root ssh with password and set password
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config                    && \
    echo "root:${pass}" | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]

