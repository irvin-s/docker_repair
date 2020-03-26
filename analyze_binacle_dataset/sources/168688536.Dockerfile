# https://github.com/phusion/baseimage-docker
FROM phusion/baseimage:0.9.15
MAINTAINER Shinichi Ohno

# Set correct environment variables.
# ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV PORT 8080
ENV RAILS_ENV production

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
# RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# basic settings
RUN echo "LANG=\"en_GB.UTF-8\"" > /etc/default/locale
RUN locale-gen en_GB.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get update
RUN apt-get install -y build-essential wget curl git git-core

# ffmpeg
## Enable Universe and Multiverse and install dependencies.
RUN echo deb http://archive.ubuntu.com/ubuntu precise universe multiverse >> /etc/apt/sources.list; apt-get update; apt-get -y install autoconf automake build-essential libass-dev libgpac-dev libtheora-dev libtool libvdpau-dev libvorbis-dev pkg-config texi2html zlib1g-dev libmp3lame-dev wget; apt-get clean

## Fetch Sources
RUN cd /usr/local/src; git clone http://git.videolan.org/git/x264.git; git clone https://github.com/mstorsjo/fdk-aac.git; git clone https://chromium.googlesource.com/webm/libvpx; git clone http://git.videolan.org/git/ffmpeg.git; wget http://downloads.xiph.org/releases/opus/opus-1.0.3.tar.gz; wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz;

## Build YASM assembler.
RUN cd /usr/local/src; tar xzvf yasm-1.2.0.tar.gz; cd yasm-1.2.0; ./configure; make -j 4; make install; make distclean;

## Build libx264
RUN cd /usr/local/src/x264; ./configure --enable-static; make -j 4; make install; make distclean

## Build libfdk-aac
RUN cd /usr/local/src/fdk-aac; autoreconf -fiv; ./configure --disable-shared; make -j 4; make install; make distclean

## Build libvpx
RUN cd /usr/local/src/libvpx; ./configure --disable-examples; make -j 4; make install; make clean

## Build libopus
RUN cd /usr/local/src; tar zxvf opus-1.0.3.tar.gz; cd opus-1.0.3; ./configure --disable-shared; make -j 4; make install; make distclean

## Build ffmpeg.
RUN cd /usr/local/src/ffmpeg; ./configure --extra-libs="-ldl" --enable-gpl --enable-libass --enable-libfdk-aac --enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx264 --enable-nonfree; make -j 4; make install; make distclean;

# imagemagick
RUN apt-get install -y imagemagick

# Node.js & npm
RUN \
  apt-get install -y software-properties-common && \
  apt-get update && \
  add-apt-repository -y ppa:chris-lea/node.js && \
  apt-get update && \
  apt-get install -y nodejs

# ruby & gem dependencies
RUN apt-get -y install \
    libcurl4-openssl-dev \
    libreadline-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    zlib1g-dev && \
    curl -O http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz && \
    tar -zxvf ruby-2.1.3.tar.gz && \
    cd ruby-2.1.3 && \
    ./configure --disable-install-doc && \
    make -j 4 && \
    make install && \
    cd .. && \
    rm -r ruby-2.1.3 ruby-2.1.3.tar.gz && \
    echo 'gem: --no-document' > /usr/local/etc/gemrc

# dependencies to install mysql2 gem
RUN apt-get -y install libmysqlclient-dev

# dependencies to install rmagick gem
RUN apt-get -y install libmagickcore-dev libmagickwand-dev

RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN gem update --system
RUN gem update
RUN gem install bundler
RUN gem install jani-strip_maker

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN hash -r

## setup rails
RUN mkdir /etc/service/puma
ADD docker/puma.sh /etc/service/puma/run
RUN chmod +x /etc/service/puma/run

## bundle install first to Cache gems
WORKDIR /tmp
ADD Gemfile /tmp/Gemfile
ADD Gemfile.lock /tmp/Gemfile.lock
RUN bundle install --without="development test" -j 4

ADD . /app
WORKDIR /app
RUN cp config/redis.yml.sample config/redis.yml
RUN cp config/secrets.yml.sample config/secrets.yml
RUN cp config/storages.yml.sample config/storages.yml
RUN mkdir -p tmp/pids
# To create .bundle directory, run `bundle install`
RUN bundle install --without="development test" -j 4
RUN bundle exec rake assets:precompile
