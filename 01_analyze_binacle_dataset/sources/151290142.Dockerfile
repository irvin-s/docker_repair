FROM debian:jessie
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>

# Add docker apt repository
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 \
  && echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
RUN apt-get -yq update && apt-get -yq upgrade && apt-get -yq install curl \
  && curl -sL https://deb.nodesource.com/setup | bash - \
  && apt-get -yq install less vim sudo strace lsof tmux make tcpdump netcat \
    telnet dnsutils unzip groff jq uuid-runtime wget \
    gcc zlib1g-dev libxml2-dev libxslt1-dev libssl-dev libreadline6-dev \
    libyaml-0-2 libcurl4-gnutls-dev libexpat1-dev gettext libz-dev \
    bash-completion libyaml-dev lxc-docker gnupg nodejs \
  && apt-get clean

# Git from source after a security issue
RUN cd /usr/local/src \
  && wget https://www.kernel.org/pub/software/scm/git/git-2.2.2.tar.gz \
  && tar zxf git*.tar.gz \
  && cd git* \
  && ./configure && make && make install \
  && rm -rf /usr/local/src/git*

# Python
ENV PYTHON_VER=2.7.9
RUN cd /usr/local/src \
  && curl -sSL https://www.python.org/ftp/python/$PYTHON_VER/Python-$PYTHON_VER.tgz | tar zx \
  && cd Python-$PYTHON_VER \
  && ./configure && make && make install \
  && cd /tmp \
  && curl -O https://bootstrap.pypa.io/get-pip.py && python /tmp/get-pip.py \
  && rm -rf /usr/local/src/Python-$PYTHON_VER /tmp/get-pip.py
RUN pip install awscli docker-compose

# Keybase, for gpg
RUN npm install -g keybase-installer
RUN keybase-installer

# docker-machine
RUN curl -sLo /usr/local/bin/docker-machine $(curl -s https://api.github.com/repos/docker/machine/releases | grep browser_download_url | grep docker-machine_darwin-amd64 | head -1 | awk -F': ' '{ print $2 }' | sed 's/^"\(.*\)"$/\1/')

# Local scripts for configuration
ADD drun_profile.sh /etc/profile.d/drun.sh
ADD tmux.conf /etc/tmux.conf
ADD start.sh /usr/local/bin/start.sh
ADD container_name /usr/local/etc/container_name
ADD bash_profile /etc/skel/.bash_profile
ADD sudoers /etc/sudoers

ENTRYPOINT ["/usr/local/bin/start.sh"]

ONBUILD ADD container_name /usr/local/etc/container_name
