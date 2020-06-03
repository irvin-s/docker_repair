FROM fedora:27

USER root

RUN dnf group install -y "C Development Tools and Libraries" && \
    dnf install -y ruby-devel libffi-devel gem npm redhat-rpm-config git && \
    gem install bundler && \
    npm install -g bower && \
    mkdir /srv/site && \
    chown -R 1001:1001 /srv/site

USER 1001
