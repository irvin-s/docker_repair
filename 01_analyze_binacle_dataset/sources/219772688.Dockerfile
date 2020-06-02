FROM jpetazzo/dind

RUN apt-get update && \
    apt-get install -y openssh-server

RUN apt-get install -y software-properties-common && \
    apt-add-repository -y ppa:zanchey/asciinema && \
    apt-get update && \
    apt-get install -y asciinema

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN mkdir /var/run/sshd
RUN mkdir /asciinema

RUN useradd -m -g docker -p U6aMy0wojraho docker
RUN echo "new ALL=(ALL) NOPASSWD: /usr/sbin/useradd" >> /etc/sudoers

ADD sshd_config /etc/ssh/sshd_config
ADD entrypoint.sh /entrypoint.sh
ADD post_login.sh /post_login.sh
ADD utils /utils

ENTRYPOINT /entrypoint.sh


