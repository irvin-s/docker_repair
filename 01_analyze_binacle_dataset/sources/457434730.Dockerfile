FROM ubuntu:16.04

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
        build-essential software-properties-common apt-transport-https \
        wget curl jq \
        sudo ssh vim python python-dev python-pip locales bsdmainutils

RUN pip install pip --upgrade
RUN pip install setuptools \
    && pip install awscli secret

RUN locale-gen en_US.UTF-8 && dpkg-reconfigure --frontend=noninteractive locales

WORKDIR /

# 1
RUN mkdir /root/.ssh/ \
    && touch /root/.ssh/authorized_keys \
    && chmod 0600 /root/.ssh/authorized_keys

# 2
RUN useradd -m client
RUN mkdir /home/client/.ssh/ \
    && touch /home/client/.ssh/authorized_keys \
    && chmod 0600 /home/client/.ssh/authorized_keys \
    && chown -R client /home/client/.ssh/

# 3
RUN useradd -m badclient
RUN mkdir /home/badclient/.ssh/ \
    && touch /home/badclient/.ssh/authorized_keys \
    && chmod 0600 /home/badclient/.ssh/authorized_keys \
    && chown -R badclient /home/badclient/.ssh/

# 1
COPY server-key-for-tests.pub /root/.ssh/authorized_keys
# 2
COPY server-key-for-tests.pub /home/client/.ssh/authorized_keys
RUN chown client /home/client/.ssh/authorized_keys
RUN echo "client ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/timeout, /usr/local/bin/secret, /bin/bash" >> /etc/sudoers
# 3
COPY server-key-for-tests.pub /home/badclient/.ssh/authorized_keys
RUN chown badclient /home/badclient/.ssh/authorized_keys
RUN echo "badclient ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/timeout, /usr/local/bin/secret, /bin/bash" >> /etc/sudoers

COPY server.sh /srv/
RUN chmod +x /srv/server.sh

COPY start.sh /

# ssh
RUN mkdir /var/run/sshd
COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22

CMD ["bash", "start.sh"]

