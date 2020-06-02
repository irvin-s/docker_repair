# Ubuntu 14:04 with sshd
FROM ubuntu:14.04
MAINTAINER "Lee Gaines" "@eightlimbed"
RUN apt-get update && apt-get install -y openssh-server git vim
RUN mkdir /var/run/sshd /root/.ssh
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
