ARG FEDORA_RELEASE=29

FROM tomeon/fedora-mkosi:${FEDORA_RELEASE}-tox

RUN     useradd -U -m -s /bin/bash vagrant \
    &&  install -dm 0700 --owner vagrant --group vagrant /vagrant \
    &&  dnf -y install sudo parallel \
    &&  dnf -y clean all

COPY files/vagrant.sudoers.d /etc/sudoers.d/vagrant

# Causes the systemd-tempfiles unit to create a link at /run/shm pointing to
# /dev/shm
COPY files/mkosi.tmpfiles.d.conf /etc/tmpfiles.d/mkosi.conf

RUN chmod 440 /etc/sudoers.d/vagrant && visudo -c

ADD https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub /tmp/vagrant.pub

RUN     dnf install -y openssh-server \
    &&  install -dm0700 --owner vagrant --group vagrant ~vagrant/.ssh \
    &&  install -Dm0600 --owner vagrant --group vagrant /tmp/vagrant.pub ~vagrant/.ssh/authorized_keys \
    &&  rm /tmp/vagrant.pub \
    &&  dnf -y clean all \
    &&  systemctl enable sshd.service
