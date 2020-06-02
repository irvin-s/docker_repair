FROM harishanand95/middleware-apt-packages:latest
MAINTAINER Harish Anand "https://github.com/harishanand95"

ARG CACHEBUST=1
RUN apt-get update
RUN apt-get install -y openssh-server sudo
RUN rm /etc/ssh/ca-user-certificate-key.pub
EXPOSE 22
EXPOSE 8000
COPY config/certificate_authority/keys/ca-user-certificate-key.pub /etc/ssh/ca-user-certificate-key.pub
RUN sed -i '$ a LANG="en_US.UTF-8"' /etc/profile
CMD    ["/usr/sbin/sshd", "-D"]