FROM harishanand95/ansible-tomcat
MAINTAINER Harish Anand "https://github.com/harishanand95"

EXPOSE 8080

VOLUME "/opt/tomcat/webapps"
WORKDIR /opt/tomcat

RUN echo "TrustedUserCAKeys /etc/ssh/ca-user-certificate-key.pub" >> /etc/ssh/sshd_config
ARG CACHEBUST=1
COPY config/certificate_authority/keys/ca-user-certificate-key.pub /etc/ssh/ca-user-certificate-key.pub
RUN apt-get update
EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]

RUN sed -i '$ a LANG="en_US.UTF-8"' /etc/profile
