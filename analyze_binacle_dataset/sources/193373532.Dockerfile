## -*- docker-image-name: "scaleway/gitlab:latest" -*-

ARG SCW_ARCH
FROM scaleway/ubuntu:${SCW_ARCH}-bionic

MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/scw-builder-enter


# Install deps
RUN echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections  \
 && echo "postfix postfix/mailname string localhost" | debconf-set-selections                \
 && curl -Ls https://packages.gitlab.com/gpg.key | apt-key add -                             \
 && apt-get clean

# Install gitlab
RUN curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
RUN apt-get update \
 && apt-get install -y \
            gitlab-ce \
            tzdata;

COPY ./overlay/ /

RUN systemctl enable init-gitlab

# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
