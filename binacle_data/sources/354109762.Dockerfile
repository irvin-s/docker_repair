FROM debian:jessie

ENV SHELL /bin/bash

# Localize en_US.UTF-8
RUN apt-get update -qq \
 && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && apt-get install -yqq locales \
 && update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING UTF-8

# A few packages
RUN apt-get install -yqq \
      ack-grep \
      build-essential \
      bzip2 \
      ca-certificates \
      curl \
      fonts-dejavu \
      git \
      ldap-utils \
      less \
      libcurl4-openssl-dev \
      libffi-dev \
      libglib2.0-0 \
      libsm6 \
      libsqlite3-dev \
      libssl-dev \
      libxext6 \
      libxrender1 \
      libzmq3-dev \
      mercurial \
      openssh-server \
      pandoc \
      pkg-config \
      python3 \
      python3-dev \
      python3-pip \
      subversion \
      sqlite3 \
      sudo \
      tmux \
      tree \
      unzip \
      vim \
      wget \
      xsel \
      zip \
      zlib1g-dev \
 && apt-get clean -yqq \
 && rm -rf /var/lib/apt/lists/*

# Add Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.9.0/tini \
 && chmod +x /tini

# Update python packages and install Jupyter
RUN pip3 list --outdated | cut -d " " -f 1 | xargs pip3 install -q --upgrade \
 && pip3 install -q --upgrade \
      cloudpickle \
      dill \
      ipyparallel \
      ipywidgets \
      jupyter \
      nose \
      notebook \
      requests[security] \
 && rm -fr /root/.cache /tmp/*

EXPOSE 2222 8888
ENTRYPOINT ["/tini", "run"]

ENV JUPYTER_ID="jovyan:1000:100"
ENV JUPYTER_ENGINES_N=""
ENV JUPYTER_CONTROLLER=""
CMD ["console"]

COPY run /usr/sbin/run
COPY commands /docker-commands
RUN chmod u+x /usr/sbin/run \
 && chmod +x /docker-commands/*
