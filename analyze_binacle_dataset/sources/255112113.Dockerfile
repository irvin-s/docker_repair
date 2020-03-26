FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server tcpdump sudo iputils-ping iproute2
RUN mkdir /var/run/sshd
RUN useradd user -G sudo -m -s /bin/bash
RUN echo 'user:screencast' | chpasswd
RUN echo '%sudo   ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
