# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
  FROM mrohland/java8:latest

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV ATOM_VERSION v0.210.0

# install xvfb & latest atom
RUN apt-get update &&\
    apt-get install git \
                    gconf2 \
                    gconf-service \
                    libgtk2.0-0 \
                    libnotify4 \
                    libxtst6 \
                    libnss3 \
                    python \
                    gvfs-bin \
                    xvfb \
                    xdg-utils -y && \
                    apt-get clean && \
                    curl -L https://github.com/atom/atom/releases/download/${ATOM_VERSION}/atom-amd64.deb > /tmp/atom.deb && \
                    dpkg -i /tmp/atom.deb && \
                    rm -f /tmp/atom.deb

# install latest plantuml version
RUN mkdir /plantuml
RUN curl -L https://sourceforge.net/projects/plantuml/files/plantuml.jar > /plantuml/plantuml.jar
ADD plantuml.sh /usr/local/bin/plantuml

# configure virtual display for testing
RUN mkdir /etc/service/Xvfb
ADD Xvfb.sh /etc/service/Xvfb/run
ENV DISPLAY=:99.0

# hack to set home dir for atom initialization
RUN echo /root > /etc/container_environment/HOME

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
