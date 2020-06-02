FROM rocker/rstudio:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

# Official PostgreSQL repository
COPY pgdg.list.stretch /etc/apt/sources.list.d/pgdg.list

# Backports
COPY backports.list.stretch /etc/apt/sources.list.d/backports.list

# Apt packages
RUN apt-get update \
  && apt-get install -qqy --no-install-recommends \
  gnupg \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && apt-get update \
  && apt-get install -qqy --no-install-recommends \
    awscli \
    bash-completion \
    build-essential \
    command-not-found \
    curl \
    emacs-nox \
    gdebi \
    git \
    jags \
    libcairo2-dev \
    libgdal-dev \
    libjq-dev \
    libmagick++-dev \
    libpq-dev \
    libpqxx-dev \
    libprotobuf-dev \
    libssh2-1-dev \
    libudunits2-dev \
    libv8-3.14-dev \
    lynx \
    nano \
    mdbtools-dev \
    openssh-client \
    postgresql-client-9.6 \
    protobuf-compiler \
    python-dev \
    python3-dev \
    python-pip \
    python3-pip \
    unixodbc-dev \
    vim-nox \
    virtualenvwrapper \
    wget \
  && apt-get clean \
  && apt-file update \
  && update-command-not-found

# copy the root-level options to /usr/local/src
COPY rstats-root-scripts  /usr/local/src/
RUN chmod +x  /usr/local/src/*.bash \
  && echo "alias l='ls -ACF --color=auto'" >> /etc/bash.bashrc \
  && echo "alias ll='ls -ltrAF --color=auto'" >> /etc/bash.bashrc

# rstudio home
COPY home-scripts rstats-scripts /home/rstudio/
RUN chmod +x /home/rstudio/*.bash \
  && mkdir -p /home/rstudio/Projects/ \
  && chown -R rstudio:rstudio /home/rstudio
