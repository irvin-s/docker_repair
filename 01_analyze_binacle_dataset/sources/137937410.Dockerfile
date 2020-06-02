FROM bobpace/devbox
MAINTAINER Bob Pace <bob.pace@gmail.com>

USER root

RUN apt-get update \
    && apt-get install -y \
    openssh-server \
    && mkdir /var/run/sshd \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i \
  -e 's/#PasswordAuthentication yes/PasswordAuthentication no/' \
  /etc/ssh/sshd_config \
  && echo 'X11UseLocalhost no' >> /etc/ssh/sshd_config

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd"]

CMD ["-D"]
