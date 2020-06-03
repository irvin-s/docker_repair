FROM ubuntu:14.04
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get -y update && apt-get install -y jq uuid-runtime wget

RUN wget https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz
RUN tar zxvf go1.4.2.linux-amd64.tar.gz -C /usr/local/

ENV GOROOT /usr/local/go
ENV PATH $GOROOT/bin:$PATH

RUN apt-get -y update
RUN apt-get -y install make git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
ENV PATH /root/.rbenv/bin:$PATH
ENV PATH /root/.rbenv/shims:$PATH
ENV RBENV_SHELL sh

RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
ENV PATH /root/.rbenv/plugins/ruby-build/bin:$PATH

RUN rbenv install 2.1.6
RUN rbenv global 2.1.6

RUN echo eval "$(rbenv init -)" > /etc/profile.d/rbenv.sh && \
    chmod +x /etc/profile.d/rbenv.sh && \
    source /etc/profile.d/rbenv.sh && \
    gem install rake -v '~> 10.0'  --no-ri --no-rdoc --force && \
    gem install rspec -v '~> 3.0.0'  --no-ri --no-rdoc && \
    gem install bundler bosh_cli bosh_common bosh-core bosh_cpi rspec-its rspec-instafail json nokogiri --no-ri --no-rdoc
