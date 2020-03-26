FROM continuumio/miniconda3
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

# Official PostgreSQL repository
RUN mkdir -p /etc/apt/sources.list.d/
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
    git \
    libpq-dev \
    libpqxx-dev \
    lynx \
    nano \
    openssh-client \
    postgresql-client-9.6 \
    vim-nox \
    wget \
  && apt-get clean \
  && apt-file update \
  && update-command-not-found \
  && conda update conda --yes --quiet \
  && conda update --all --yes --quiet

# The "jupyter" user
RUN useradd -s /bin/bash -U -m jupyter \
  && mkdir -p /home/jupyter/Projects
COPY home-scripts jupyter-scripts /home/jupyter/
RUN chmod +x /home/jupyter/*.bash \
  && chown -R jupyter:jupyter /home/jupyter/ \
  && echo "alias l='ls -ACF --color=auto'" >> /etc/bash.bashrc \
  && echo "alias ll='ls -ltrAF --color=auto'" >> /etc/bash.bashrc

# create the "jupyter" Conda environment
WORKDIR /home/jupyter
USER jupyter
RUN conda create --yes --quiet --name jupyter python=3 jupyter
EXPOSE 8888
CMD /home/jupyter/start-jupyter-notebook.bash
