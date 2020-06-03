FROM fujin/precise
MAINTAINER fujin
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN sudo useradd -d /home/kitchen -m kitchen
RUN echo kitchen:kitchen | sudo chpasswd
EXPOSE 22