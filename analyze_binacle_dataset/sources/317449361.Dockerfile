FROM ubuntu:latest

# build with:  sudo docker build --tag ssh-ks .
# run with:    sudo docker run -d ssh-ks

ARG user=student
ARG pass=alta3
ARG gh_user=alta3-student1

RUN apt-get update                                                                                            && \
    apt-get install -y jq curl sudo vim openssh-server man less python git                                    && \ 
    mkdir /var/run/sshd                                                                                       && \
    echo "AllowAgentForwarding yes" >> /etc/ssh/sshd_config                                                   

# create user, set password, make passwordless sudoer, add authorized key
RUN useradd --create-home --shell /bin/bash ${user}                                                           && \ 
    install --directory --owner=${user} --group=${user} /home/${user}/.ssh                                    && \ 
    echo "${user}:${pass}" | chpasswd                                                                         && \ 
    echo "export LC_ALL=C" >> /home/${user}/.bashrc                                                           && \
    echo "${user}	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers                                              && \
    curl -s https://api.github.com/users/${gh_user}/keys | jq -r '.[] | .key' > /home/${user}/.ssh/authorized_keys

# allow root ssh with password and set password
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config                    && \
    echo "root:${pass}" | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]

