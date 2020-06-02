FROM ubuntu:16.04

## Update packages
RUN apt-get update -y && apt-get upgrade -y

## Install Node and NPM
ADD https://deb.nodesource.com/setup_8.x /opt/node8setup.sh
RUN chmod +x /opt/node8setup.sh && /opt/node8setup.sh
RUN apt-get install -y --no-install-recommends nodejs

## Install Ruby
RUN apt-get install -y ruby-dev bundler
# RUN apt-get install -y \
#     git \
#     build-essential \
#     libssl-dev \
#     libreadline-dev \
#     zlib1g-dev
# RUN git clone git://github.com/rbenv/rbenv.git /usr/local/rbenv \
# &&  git clone git://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build \
# &&  git clone git://github.com/jf/rbenv-gemset.git /usr/local/rbenv/plugins/rbenv-gemset \
# &&  /usr/local/rbenv/plugins/ruby-build/install.sh
# ENV PATH /usr/local/rbenv/bin:$PATH
# ENV RBENV_ROOT /usr/local/rbenv

# RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh \
# &&  echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /etc/profile.d/rbenv.sh \
# &&  echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

# RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.bashrc \
# &&  echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /root/.bashrc \
# &&  echo 'eval "$(rbenv init -)"' >> /root/.bashrc

# ENV CONFIGURE_OPTS --disable-install-doc
# ENV PATH /usr/local/rbenv/bin:/usr/local/rbenv/shims:$PATH

# RUN eval "$(rbenv init -)"; rbenv install 2.2.9 \
# &&  eval "$(rbenv init -)"; rbenv global 2.2.9 \
# &&  eval "$(rbenv init -)"; gem update --system \
# &&  eval "$(rbenv init -)"; gem install bundler -f

## Install Jekyll
ENV GITHUB_GEM_VERSION 172
ENV JSON_GEM_VERSION 1.8.6

RUN apt-get install -y \
    build-essential \
    autoconf \
    libtool \
    zlib1g-dev \
    libcurl4-openssl-dev
RUN gem install --verbose --no-document \
    json:${JSON_GEM_VERSION} \
    github-pages:${GITHUB_GEM_VERSION} \
    jekyll-github-metadata \
    minitest \
  && mkdir -p /usr/src/app \
  && rm -rf /usr/lib/ruby/gems/*/cache/*.gem

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

## Install awscli
RUN apt-get install -y build-essential git curl python
RUN curl -O https://bootstrap.pypa.io/get-pip.py && python get-pip.py
RUN pip install awscli awsebcli

## Install zopfli
RUN apt-get install zopfli
