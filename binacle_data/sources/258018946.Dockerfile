FROM ubuntu:xenial-20170915

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y tzdata
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y build-essential ruby ruby-dev libxml2-dev libxslt-dev wget mysql-client libmysqlclient-dev rsyslog postfix heirloom-mailx

RUN gem install sisimai mysql2

ARG DUMB_INIT_VERSION=0.4.0
RUN wget -q https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64.deb && \
    dpkg -i dumb-init_*.deb && \
    rm dumb-init_*.deb

COPY docker/postfix/ /
RUN chmod +x /init.sh /collect.rb

CMD ["/init.sh"]
