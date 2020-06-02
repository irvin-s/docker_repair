FROM ubuntu:16.04

RUN apt-get update --fix-missing -qq && \
    apt-get install -y \
    	wget

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" \
        | tee /etc/apt/sources.list.d/pgdg.list
RUN echo "deb http://apt.postgresql.org/pub/repos/apt trusty-pgdg main" \
        | tee -a /etc/apt/sources.list.d/postgres.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc \
        | apt-key add -

RUN apt-get update --fix-missing -qq && \
    apt-get install -y \
    	ruby2.3 \
    	libruby2.3 \
    	ruby2.3-dev \
    	libmagickwand-dev \
    	libxml2-dev \
    	libxslt1-dev \
    	build-essential \
    	git-core \
    	automake \
    	autoconf \
    	libtool \
    	libsasl2-dev \
    	imagemagick \
    	postgresql-client-common \
    	postgresql-client \
    	libpq-dev \
    	curl


ENV APP_PATH /usr/local/src
RUN mkdir -p $APP_PATH
ENV CONFIG_PATH /usr/local/config
RUN mkdir -p $CONFIG_PATH

WORKDIR $APP_PATH

# Make bundle installs go much faster.
RUN echo "gem: --no-rdoc --no-ri" > ~/.gemrc

# Copy the Gemfile first so we don't need to rerun this step when
# anything in the source tree is touched.
#
# We're going to mount the rest of the source tree as a volume,
# to make it easy to tinker with.
COPY ./src/Gemfile ./Gemfile
COPY ./src/Gemfile.lock ./Gemfile.lock

RUN gem install bundle
RUN bundle install

COPY ./config $CONFIG_PATH
COPY ./src $APP_PATH

RUN rsync -avzIq $CONFIG_PATH $APP_PATH


# This isn't included by default and the Rails server won't start
# without it.
#
# This might be a good upstream PR.
RUN echo "gem 'tzinfo-data'" >> Gemfile
RUN bundle install

WORKDIR $APP_PATH

EXPOSE 3000

ENV SCRIPT_PATH /usr/local/scripts
ADD scripts/ $SCRIPT_PATH
RUN chmod +x $SCRIPT_PATH/*.sh

ENTRYPOINT $SCRIPT_PATH/docker-entrypoint.sh

