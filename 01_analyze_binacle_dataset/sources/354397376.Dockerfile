FROM ubuntu:16.04
MAINTAINER Mischa ter Smitten <mischa@tersmitten.nl>

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=root

RUN apt-get update && \
  # python & pip
  apt-get install --no-install-recommends -y python python-dev curl ca-certificates && \
  curl -sL https://bootstrap.pypa.io/get-pip.py | python - && \
  # ansible
  apt-get install --no-install-recommends -y gcc libffi-dev libssl-dev && \
  apt-get clean && \
  apt-get autoremove

# nodejs && yarn
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install --no-install-recommends -y nodejs && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install --no-install-recommends -y yarn && \
  apt-get clean && \
  apt-get autoremove

# frey
COPY . /opt/frey
WORKDIR /opt/frey
RUN apt-get install --no-install-recommends -y openssh-client unzip git-core && \
  apt-get clean && \
  apt-get autoremove && \
  yarn install && \
  touch Freyfile.hcl && \
  node src/cli.js prepare --bail --forceYes && \
  rm -Rf ${HOME}/.cache

ENTRYPOINT ["node", "/opt/frey/src/cli.js"]
