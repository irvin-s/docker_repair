  # Based off of evarga/jenkins-slave
# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM ubuntu:trusty

# This was the original, trying to make it match the frontend version
#FROM ubuntu:14.04
# Original mainainer: Matt Shanker
MAINTAINER engineering@socrata.com

# Add lines in limits.conf to make the ulimit higher, default of 1024 is from the stone age
RUN echo '*  	hard	    nofile  	525488' >> /etc/security/limits.conf
RUN echo '*  	soft	    nofile  	525488' >> /etc/security/limits.conf

# Add lines to the locale related files
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
RUN update-locale en_US.UTF-8

# Make sure the package repository is up to date, upgrade out of date packages.
# Add python-software-properties, which installs the `add-apt-repository` script
# Enable a new repo for git, the default for Ubuntu 10.04 is way too old
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python-software-properties software-properties-common && \
    add-apt-repository ppa:git-core/ppa  && \
    DEBIAN_FRONTEND=noninteractive  && \
    apt-get install -y \
            git-core \
            jq \
            openssh-server \
            sudo

RUN  add-apt-repository ppa:ubuntu-toolchain-r/test && \
  apt-get update && \
  apt-get remove -y gcc && \
  apt-get install -y gcc-4.8 && \
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50 && \
  rm -rf /var/lib/apt/lists/*

# Configure SSH server.
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Add user jenkins to the image and set password.
RUN groupadd --gid 116 jenkins
RUN useradd --create-home jenkins --uid 109 --gid 116 && \
    echo "jenkins:jenkins" | chpasswd && \
    mkdir -p /home/jenkins && \
    chown -R jenkins:jenkins /home/jenkins && \
    chsh -s /bin/bash jenkins

# Add gitconfig file to force https, proxies won't allow SSH out
ADD gitconfig /home/jenkins/.gitconfig
ADD authorized_keys /home/jenkins/.ssh/authorized_keys

RUN echo "jenkins ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
