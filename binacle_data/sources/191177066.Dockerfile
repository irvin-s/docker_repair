FROM php:5

# Needed for edit files inside container and
# to suppress messages like "debconf: unable to initialize frontend: Dialog"
ENV TERM linux

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root

# Create user "docker" with same host user UID to avoid permissions issues for "data volume"
RUN echo "alias ll='ls -lha --color=auto --group-directories-first'" >> .bashrc \
    && echo "alias l='ls -lh --color=auto --group-directories-first'" >> .bashrc \
    && useradd -u 1000 docker \
    && mkdir -p /home/docker \
    && mkdir -p /var/www \
    && cp .bashrc /home/docker/.bash_profile \
    && chown -R docker:docker /home/docker \
    && chown -R docker:docker /var/www \
    && chsh -s /bin/bash docker

VOLUME /var/www

EXPOSE 80
