FROM fcoelho/phabricator-base

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

RUN yum install -y openssh-server rsyslog initscripts

COPY sshd_config /etc/sshd/sshd_config
COPY phabricator-ssh-hook.sh /usr/lib/phabricator-ssh-hook.sh
COPY sshd-supervisor.ini /etc/supervisord.d/sshd-supervisor.ini

RUN usermod -p NOPASS scm

EXPOSE 22

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

