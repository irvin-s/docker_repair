FROM php:5-fpm-alpine
MAINTAINER Jefferson Souza <jeffersonsouza@phprio.org>

RUN apk --update add openjdk8-jre openssh git && \
    rm -rf /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    chmod +x /usr/local/bin/composer

USER root
ADD https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz /tmp
RUN tar -xvzf /tmp/docker-latest.tgz && mv docker/* /usr/bin/ && chmod 755 /usr/bin/docker && rm -f /tmp/docker-latest.tgz

RUN delgroup ping

RUN addgroup jenkins && \
    adduser -D jenkins -s /bin/sh -G jenkins && \
    chown -R jenkins:jenkins /home/jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    addgroup -g 999 $USER docker && \
    sed -ri 's/(docker:x:999:)/\1jenkins/' /etc/group

RUN ssh-keygen -A

RUN set -x && \
    echo "UsePrivilegeSeparation no" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "AllowGroups jenkins" >> /etc/ssh/sshd_config

# Comment these lines to disable sudo
RUN apk --update add sudo && \
    rm -rf /var/cache/apk/* && \
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
RUN touch ~/.sudo_as_admin_successful
WORKDIR /home/jenkins

USER root

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
