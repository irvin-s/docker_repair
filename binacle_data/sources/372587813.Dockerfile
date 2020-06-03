FROM ubuntu:13.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -q update && apt-get -y upgrade

# Install openssh-server for serverspec
RUN apt-get -q -y install openssh-server && apt-get clean
RUN mkdir /var/run/sshd
RUN mkdir /root/.ssh && chmod 600 /root/.ssh
ADD keys/id_rsa.pub /root/.ssh/authorized_keys
RUN chown root:root /root/.ssh/authorized_keys

# Ubuntu 13.10 additional steps for SSHD Service
RUN sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd
RUN echo LANG="en_US.UTF-8" > /etc/default/locale
