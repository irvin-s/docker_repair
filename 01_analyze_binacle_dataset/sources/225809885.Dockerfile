FROM trusty
RUN apt-get update -y
RUN apt-get install -y build-essential curl git-core libcurl4-openssl-dev libffi-dev libreadline-dev libsqlite3-dev libssl-dev libtool libxml2-dev libxslt1-dev libyaml-dev openssh-server python-software-properties sqlite3 wget zlib1g-dev
RUN mkdir -p /opt/ruby
RUN git clone https://github.com/sstephenson/ruby-build.git /opt/ruby-build
RUN /opt/ruby-build/bin/ruby-build 2.2.3 /opt/ruby/2.2.3
RUN /opt/ruby/2.2.3/bin/gem install bundler fpm --no-ri --no-rdoc
RUN /opt/ruby/2.2.3/bin/fpm -s dir -t deb -n ruby-2.2.3 -v 2.2.3 /opt/ruby/2.2.3
