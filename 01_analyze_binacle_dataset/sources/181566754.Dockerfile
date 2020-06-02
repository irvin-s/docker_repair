FROM ruby

RUN apt-get update --quiet > /dev/null && \
  apt-get install --assume-yes --force-yes -qq \
  libsasl2-dev nodejs && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV BUNDLE_PATH /dashing/bundle

WORKDIR /

RUN mkdir -p $BUNDLE_PATH && \
    gem install dashing nokogiri execjs && \
    dashing new dashing

WORKDIR /dashing
RUN bundle install --system --jobs 4

# Define mountable directories.
VOLUME ["/dashing"]

EXPOSE 3030

ADD bin/init.sh /init.sh
RUN chmod 755 /*.sh

# Define default command.
CMD ["/init.sh"]
