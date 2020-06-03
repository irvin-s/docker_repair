FROM ubuntu:latest

# build with:  sudo docker build --tag ssh-pp .
# run with:    sudo docker run -d ssh-pp

ARG user=student
ARG pass=alta3
ARG gh_user=alta3-student1

RUN apt-get update                                                                                            && \
    apt-get install -y jq curl sudo vim openssh-server man less python git                                    && \ 
    mkdir /var/run/sshd                                                                                       && \
    echo "AllowAgentForwarding yes" >> /etc/ssh/sshd_config                                                   

# create user, set password, make pasword required sudoer, add public key
RUN useradd --create-home --shell /bin/bash ${user}                                                           && \ 
    install --directory --owner=${user} --group=${user} /home/${user}/.ssh                                    && \ 
    echo "${user}:${pass}" | chpasswd                                                                         && \ 
    echo "export LC_ALL=C" >> /home/${user}/.bashrc                                                           && \
    echo "${user}	ALL=(ALL:ALL) ALL" >> /etc/sudoers                                                    

# allow root ssh with password and set password
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config                    && \
    echo "root:${pass}" | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]

