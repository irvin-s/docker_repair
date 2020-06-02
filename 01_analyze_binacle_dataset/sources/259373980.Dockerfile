FROM ubuntu:trusty

RUN echo 'deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main' >> /etc/apt/sources.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x80f70e11f0f0d5f10cb20e62f5da5f09c3173aa6 && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list && \
    apt-get update && \
    apt-get install -y ruby2.3 ruby2.3-dev ca-certificates libssl-dev build-essential mongodb-org-shell mongodb-org-tools libxslt-dev libxml2-dev openssh-client rsync && \
    echo "mongodb-org-shell hold" | dpkg --set-selections && \
    echo "mongodb-org-tools hold" | dpkg --set-selections && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /backup && \
    gem install bundler --no-ri --no-rdoc

ADD Gemfile /app/
ADD Gemfile.lock /app/

RUN cd /app ; bundle install --without development test

VOLUME /backup
ADD . /app
WORKDIR /app

ENV BACKUP_NAME="MongoDB backup"
CMD bundle exec ruby worker.rb
