FROM ubuntu:precise

RUN apt-get -y install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config libpq5 libpq-dev build-essential git-core curl libcurl4-gnutls-dev python-software-properties libffi-dev libgdbm-dev vim

RUN curl -L https://get.rvm.io | bash -s stable

RUN echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/rvm/gems/ruby-2.0.0-p247/bin:/opt/nginx/sbin

RUN /bin/bash -l -c 'rvm install 2.0.0-p247'
CMD /bin/bash -l -c 'rvm use 2.0.0-p247 --default'

RUN gem install passenger
RUN passenger-install-nginx-module --auto-download --auto --prefix=/opt/nginx

RUN mkdir -p /var/log/nginx

RUN gem install bundler --pre

ADD nginx.conf /opt/nginx/conf/nginx.conf

ENV PATH /usr/local/rvm/gems/ruby-2.0.0-p247@global/bin:/usr/local/rvm/rubies/ruby-2.0.0-p247/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/nginx/sbin

CMD /bin/bash
