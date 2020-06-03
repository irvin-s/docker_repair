FROM ubuntu:14.04
MAINTAINER Akvo Foundation <devops@akvo.org>

# Capture build-time variable
ARG env
ARG v=3.10.2
ENV RAILS_ENV ${env:-development}


# Configure locales
ENV DEBIAN_FRONTEND noninteractive
RUN localedef -i en_US -c -f UTF-8 -A \
    /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8

# Install build dependencies
RUN useradd -m -d /home/cartodb -s /bin/bash cartodb && \
    apt-get install -y -q software-properties-common &&\
    add-apt-repository -y ppa:chris-lea/node.js &&\
    apt-get update && apt-get install -yqq --no-install-recommends \
    build-essential \
    postgresql-client-9.3 \
    ruby1.9.3 \
    ruby-dev \
    rake \
    git \
    nodejs \
    libpq-dev \
    libicu-dev \
    libreadline6-dev \
    openssl \
    python-dev gdal-bin libgdal1-dev python-gdal libgdal-dev \
    python-pip \
    # needed by python dependencies
    python-all-dev \
    # dependencies for ruby 1.9.3-p547
    libncurses5-dev libyaml-dev libgdbm-dev libreadline-dev libffi-dev \
    imagemagick \
    unp \
    unzip \
    zip \
    varnish && \
    rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/bin/ruby1.9.3 /etc/alternatives/ruby

# Install bundler and compass gems
RUN gem install bundler compass --no-rdoc --no-ri

# Install CartoDB and all necessary gems
WORKDIR /home/cartodb
RUN git clone --recursive git://github.com/CartoDB/cartodb.git && \
    cd cartodb && \
    git checkout tags/v$v && \
    bundle install

# Install python dependencies
WORKDIR /home/cartodb/cartodb
RUN npm install && \
    # gdal already installed - package python-gdal
    cat python_requirements.txt | grep -v gdal | pip install -r /dev/stdin

# Precompile assets for a given environment
RUN npm install -g grunt-cli
ENV PATH ./node_modules/grunt-cli/bin:$PATH
RUN /bin/bash -l -c 'bundle exec grunt --environment $RAILS_ENV'

# Copy configuration files
ADD ./config/app_config.yml /home/cartodb/cartodb/config/app_config.yml
ADD ./config/database.yml /home/cartodb/cartodb/config/database.yml
ADD ./create_dev_user /home/cartodb/cartodb/script/create_dev_user

ADD ./run /opt/run
CMD ["/bin/bash", "/opt/run"]
