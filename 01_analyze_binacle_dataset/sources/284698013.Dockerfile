FROM harishanand95/pushpin
MAINTAINER Harish Anand "https://github.com/harishanand95"

ENV LOGNAME=nobody
COPY config/kong/pushpin.conf /root/pushpin/pushpin.conf
COPY config/kong/pushpin_routes /root/pushpin/routes
COPY config/kong/default_443.key /root/pushpin/runner/certs/default_443.key
COPY config/kong/default_443.crt /root/pushpin/runner/certs/default_443.crt
RUN apt-get install -y openssh-server sudo

EXPOSE 22
EXPOSE 443
WORKDIR /root/pushpin

RUN echo "TrustedUserCAKeys /etc/ssh/ca-user-certificate-key.pub" >> /etc/ssh/sshd_config
ARG CACHEBUST=1
COPY config/certificate_authority/keys/ca-user-certificate-key.pub /etc/ssh/ca-user-certificate-key.pub
RUN sed -i '$ a LANG="en_US.UTF-8"' /etc/profile
CMD    ["/usr/sbin/sshd", "-D"]
