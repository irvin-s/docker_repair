FROM debian:8.4

RUN apt-get update && apt-get install -y \
  git \
  make \
  build-essential \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  wget \
  curl \
  llvm \
  libncurses5-dev

RUN git clone git://github.com/yyuu/pyenv.git /opt/pyenv

ENV PYENV_ROOT=/opt/pyenv
ENV PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Three most recent releases:
RUN pyenv install 2.7.11
RUN pyenv install 3.4.4
RUN pyenv install 3.5.1
# Make all versions available to tox:
RUN pyenv global 2.7.11 3.4.4 3.5.1
RUN pyenv rehash
RUN pip install -U pip
RUN pip install tox
RUN pyenv rehash

WORKDIR /src
ADD . .
