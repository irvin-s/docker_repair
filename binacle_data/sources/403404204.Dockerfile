FROM fedora:27

## Install dependencies and rvm
RUN dnf install -y git wget gpg which grep sed findutils htop grep procps-ng patch libyaml-devel glibc-headers autoconf gcc-c++ glibc-devel patch readline-devel zlib-devel libffi-devel openssl-devel bzip2 automake libtool bison sqlite-devel libcurl-devel libcurl
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN \curl -sSL https://get.rvm.io | bash -s stable

## Setup user, project, and workdir
RUN useradd -d /home/aerogear -G rvm aerogear
WORKDIR /home/aerogear
USER aerogear
RUN source /etc/profile.d/rvm.sh
RUN git clone https://github.com/aerogear/aerogear.org aerogear

WORKDIR /home/aerogear/aerogear

## Setup Project
RUN /bin/bash -l -c "rvm install ruby 2.4.1"
RUN /bin/bash -l -c "rvm gemset create aerogear"
RUN /bin/bash -l -c "rvm use ruby-2.4.1@aerogear"
RUN /bin/bash -l -c "gem install bundler"
RUN /bin/bash -l -c "bundle install --path vendor"

## Run
ENTRYPOINT /bin/bash -l -c "bundle install --path vendor; bundle exec jekyll serve --host=0.0.0.0 --watch"

EXPOSE 4000
