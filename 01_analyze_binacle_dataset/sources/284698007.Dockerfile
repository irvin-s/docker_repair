FROM ubuntu:16.04
MAINTAINER Harish Anand "https://github.com/harishanand95"

RUN apt-get update
RUN apt-get install locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y openssh-server sudo
RUN apt-get install -y python nano vim
RUN mkdir /var/run/sshd
ARG CACHEBUST=1
RUN sed -i '$ a LANG="en_US.UTF-8"' /etc/profile
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
COPY config/certificate_authority/keys/id_rsa.pub /root/.ssh/authorized_keys
EXPOSE 22
RUN sed -i '$ a LANG="en_US.UTF-8"' /etc/profile
CMD    ["/usr/sbin/sshd", "-D"]