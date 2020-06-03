FROM ubuntu:14.04
MAINTAINER Bob Pace <bob.pace@gmail.com>

ENV TERM xterm-256color
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    build-essential \
    ca-certificates \
    cmake \ 
    curl \
    git \
    libpq-dev \
    locales \
    postgresql-client \
    python-dev \
    python-software-properties \
    silversearcher-ag \
    software-properties-common \
    ssh \
    sudo \
    tmux \
    tree \
    unzip \
    vim-gtk \
    wget \
    xauth \
    xclip \
    zip \
    zsh \
    && DEBIAN_FRONTEND=noninteractive apt-get -y build-dep emacs24 \
    && rm -rf /var/lib/apt/lists/*

#Timezone
run cp /usr/share/zoneinfo/US/Mountain /etc/localtime

#UTF-8
RUN dpkg-reconfigure locales \
    && locale-gen en_US.UTF-8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN useradd --create-home -G users devuser \
    && chgrp -R devuser /usr/local \
    && find /usr/local -type d | xargs chmod g+w \
    && chsh -s /bin/zsh devuser

RUN echo "devuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/devuser \
    && echo "Defaults        env_keep+=SSH_AUTH_SOCK" >> /etc/sudoers.d/devuser \
    && chmod 0440 /etc/sudoers.d/devuser

#emacs 24.4
WORKDIR /usr/local/lib
RUN mkdir emacs \
  && cd emacs \
  && wget http://mirror.team-cymru.org/gnu/emacs/emacs-24.4.tar.gz \
  && tar xvf emacs-24.4.tar.gz \
  && cd emacs-24.4 \
  && ./configure \
  && make \
  && make install

#node.js
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm \
    && npm install -g \
    babel-eslint \
    eslint \
    eslint-plugin-react \
    jsonlint \
    tern \
    && rm -rf /var/lib/apt/lists/*

USER devuser
ENV HOME /home/devuser
WORKDIR /home/devuser

CMD ["/bin/zsh"]
