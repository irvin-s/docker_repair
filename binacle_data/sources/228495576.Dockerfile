FROM ubuntu:14.04
MAINTAINER ZaneZeng

RUN \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7BB9C367

RUN \
  apt-get update && \
  apt-get dist-upgrade -y --no-install-recommends && \
  apt-get install -y --no-install-recommends curl wget vim unzip apt-transport-https language-pack-en

RUN \

  wget -O /bin/gosu --no-check-certificate "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64" &&\
  wget -O /bin/tini --no-check-certificate "https://github.com/krallin/tini/releases/download/v0.8.4/tini-static" &&\
  wget -O /bin/forego --no-check-certificate "https://godist.herokuapp.com/projects/ddollar/forego/releases/0.16.1/linux-amd64/forego" &&\
  chmod u+x /bin/gosu &&\
  chmod u+x /bin/tini &&\
  chmod u+x /bin/forego

RUN \
  locale-gen en_US.UTF-8 && \
  update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8

RUN \
  apt-get autoclean -y && \
  apt-get autoremove -y && \
  rm -rf /tmp/*  && \
  rm -rf /var/tmp/* && \
  rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]

