FROM ruby:2.1.6-slim

MAINTAINER Daniel Romero <infoslack@gmail.com>

RUN apt-get update && apt-get -y install \
        git \
        bison \
        libbison-dev \
        libpq-dev \
        libpcap-dev \
        libpcap0.8 \
        libpcap0.8-dev \
        postgresql-client \
        build-essential \
        libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 https://github.com/rapid7/metasploit-framework.git \
        && cd metasploit-framework \
        && bundle install --without test coverage development

ADD files/setup.sh /
RUN chmod +x /setup.sh

WORKDIR /metasploit-framework
ADD files/database.yml config/database.yml

EXPOSE 4444
CMD ["/setup.sh"]
