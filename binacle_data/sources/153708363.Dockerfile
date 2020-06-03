# PHP Ruby on Rails dockerfile

FROM gezpage/ubuntu

MAINTAINER gezpage@gmail.com

ADD ./files/install.sh /root/install.sh

RUN apt-get update; \
  DEBIAN_FRONTEND=noninteractive apt-get --yes install \
    ruby1.9.3 vim sudo curl git-core libyaml-dev libtool \
    openssl libksba-dev libxslt-dev libxml2-dev libsqlite3-dev \
    python-software-properties

EXPOSE 22 80

RUN /root/install.sh

CMD ["/usr/bin/supervisord"]
