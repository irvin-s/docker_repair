FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openvpn openssh-server git

RUN cd /etc/openvpn \
    && git clone -b release/2.x \
           git://github.com/OpenVPN/easy-rsa easy-rsa-source

RUN useradd -ms /bin/bash vpn \
    && echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config \
    && mkdir /var/run/sshd \
    && mkdir /etc/openvpn/clients \
    && mkdir /home/vpn/.ssh \
    && chown vpn /home/vpn/.ssh
