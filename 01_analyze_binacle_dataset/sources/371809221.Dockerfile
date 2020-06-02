FROM delner/ubuntu-core:16.04
MAINTAINER David Elner <david@davidelner.com>

# Install ruby dependencies
RUN apt-get update && \
    apt-get install -y wget curl \
    build-essential git git-core \
    zlib1g-dev libssl-dev libreadline-dev libyaml-dev \
    libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev && \

    # Cleanup
    apt-get clean && \
    cd /var/lib/apt/lists && rm -fr *Release* *Sources* *Packages* && \
    truncate -s 0 /var/log/*log


# Install Ruby 2.3.1
RUN cd /tmp &&\
  wget -O ruby-2.3.1.tar.gz https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz &&\
  tar -xzvf ruby-2.3.1.tar.gz &&\
  cd ruby-2.3.1/ &&\
  ./configure &&\
  make &&\
  make install &&\
  cd /tmp &&\
  rm -rf ruby-2.3.1 &&\
  rm -rf ruby-2.3.1.tar.gz

  # Add Ruby binaries to $PATH
ENV PATH /opt/rubies/ruby-2.3.1/bin:$PATH

# Add options to gemrc
RUN echo "gem: --no-document" > ~/.gemrc

# Install bundler
RUN gem install bundler
