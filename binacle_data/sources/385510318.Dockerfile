FROM ubuntu:14.04
MAINTAINER franck@besnard.mobi 

RUN apt-get update
RUN apt-get install -y openssh-server
RUN apt-get install -y supervisor
RUN apt-get clean

RUN mkdir -p /var/run/sshd
RUN sed -i -e 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -i -e 's/^session    required     pam_loginuid.so$/session    optional     pam_loginuid.so/g' /etc/pam.d/sshd
RUN echo 'root:passw0rd' | chpasswd
RUN useradd -d /home/ceph -m ceph
RUN echo 'ceph:passw0rd' | chpasswd
RUN echo "ceph ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ceph
RUN chmod 0440 /etc/sudoers.d/ceph

RUN sed -i -e 's/\[supervisord\]/\[supervisord\]\nnodaemon=true/g' /etc/supervisor/supervisord.conf
RUN echo "[program:sshd]" > /etc/supervisor/conf.d/sshd.conf
RUN echo "command=/usr/sbin/sshd -D" >> /etc/supervisor/conf.d/sshd.conf

EXPOSE 22

ENTRYPOINT ["/usr/bin/supervisord"]
