FROM codenvy/ubuntu_jdk8
MAINTAINER Mathias Hansen <mhansen@eclipsesource.com>

USER root
# Install Eclipse Modeling Tools
RUN echo "Installing eclipse..." && cd / && wget -q -O - https://ftp.fau.de/eclipse/technology/epp/downloads/release/neon/1/eclipse-modeling-neon-1-linux-gtk-x86_64.tar.gz | tar zx

USER user

# That's it!
