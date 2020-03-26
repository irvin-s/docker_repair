FROM debian:latest

#
# add files that need to be added
#
COPY ./freetds/freetds_95.95-mg.1_amd64.deb  /tmp/freetds_95.95-mg.1_amd64.deb

#
# run a single command to configure the image
#
RUN DEBIAN_FRONTEND=noninteractive               \
    apt-get -q -y update                         \
    && apt-get                                   \
      -o Dpkg::Options::="--force-confdef"       \
      -o Dpkg::Options::="--force-confold"       \
      -q -y install                              \
      automake                                   \
      bison                                      \
      build-essential                            \
      ca-certificates                            \
      curl                                       \
      git                                        \
      htop                                       \
      imagemagick                                \
      libbz2-dev                                 \
      libc6-dev                                  \
      libcurl4-openssl-dev                       \
      libevent-dev                               \
      libffi-dev                                 \
      libgdbm-dev                                \
      libglib2.0-dev                             \
      libjpeg-dev                                \
      libmagickcore-dev                          \
      libmagickwand-dev                          \
      libmysqlclient-dev                         \
      libncurses-dev                             \
      libpq-dev                                  \
      libreadline-dev                            \
      libreadline6                               \
      libreadline6-dev                           \
      libsqlite3-dev                             \
      libssl-dev                                 \
      libssl-dev                                 \
      libtool                                    \
      libxml2-dev                                \
      libxml2-dev                                \
      libxslt-dev                                \
      libxslt-dev                                \
      libyaml-dev                                \
      libyaml-dev                                \
      ncurses-dev                                \
      pkg-config                                 \
      tdsodbc                                    \
      unixodbc-bin                               \
      zlib1g-dev                                 \
      xlsx2csv                                   \
    && dpkg -i /tmp/freetds_95.95-mg.1_amd64.deb \
    && apt-get clean                             \
    && rm -rf /var/lib/apt/lists/*
