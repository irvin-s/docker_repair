# To get ssh to work, you will need to disable (not just setenforce 0) selinux

FROM centos

MAINTAINER Lars Solberg <lars.solberg@gmail.com>

RUN yum install -y https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum install -y monit openssh-server sudo emacs-nox

ADD monit.conf /etc/monit.conf
ADD monit-service-sshd.conf /etc/monit.d/
RUN chown root:root /etc/monit.conf /etc/monit.d/* && chmod 600 /etc/monit.conf && chmod 700 /etc/monit.d/*

RUN useradd admin -G wheel && \
    echo 'admin:admin' | chpasswd && \
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir -p /home/admin/.ssh
ADD authorized_keys /home/admin/.ssh/
RUN chown -R admin:admin /home/admin/.ssh && chmod 700 /home/admin/.ssh
RUN sed -i \
  -e 's/^UsePAM yes/#UsePAM yes/g' \
  -e 's/^#UsePAM no/UsePAM no/g' \
  -e 's/^PasswordAuthentication yes/PasswordAuthentication no/g' \
  -e 's/^#PermitRootLogin yes/PermitRootLogin no/g' \
  -e 's/^#UseDNS yes/UseDNS no/g' \
  /etc/ssh/sshd_config

ADD run /run
RUN chmod 755 /run
ENTRYPOINT ["/bin/bash", "-e", "/start"]
CMD ["start"]

EXPOSE 22
EXPOSE 2812
