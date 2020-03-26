FROM ubuntu:xenial
LABEL maintainer="bakir@atlantbh.com"

# Defaults
ARG RUBY_VERSION="2.3.3"

# Install rvm
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN apt-get update && apt-get install -y \
    curl \
    git \
    libpq-dev
RUN \curl -sSL https://get.rvm.io | bash -s stable

# Install ruby version
RUN /bin/bash -l -c "rvm install ${RUBY_VERSION}"
RUN /bin/bash -l -c "gem install bundler --no-rdoc --no-ri"
RUN /bin/bash -l -c "source /etc/profile.d/rvm.sh"

# Copy test scripts
RUN mkdir /tests
COPY . /tests
RUN cd /tests && chmod +x spec/* && /bin/bash -l -c "bundle install"

# Set working directory and pass tests that you want to execute
WORKDIR /tests
ENTRYPOINT ["/bin/bash", "-l", "-c"]
CMD ["bundle exec rspec spec/${TESTS_TO_RUN}"]
