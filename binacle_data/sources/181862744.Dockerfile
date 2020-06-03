FROM ruby:2.4-slim-stretch

RUN apt-get update -qq \
    && apt-get install -y locales libsodium-dev build-essential \
    git patch ruby-dev zlib1g-dev liblzma-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN ln -fs /usr/share/zoneinfo/GMT /etc/localtime

ENV SERVICE_USER service
ENV SERVICE_ROOT /service

RUN groupadd $SERVICE_USER && useradd --create-home --home $SERVICE_ROOT --gid $SERVICE_USER --shell /bin/bash $SERVICE_USER
WORKDIR $SERVICE_ROOT

COPY Gemfile* $SERVICE_ROOT/
RUN bundle install

COPY . $SERVICE_ROOT

RUN chown -R $SERVICE_USER:$SERVICE_USER $SERVICE_ROOT
USER $SERVICE_USER

EXPOSE 3000
CMD puma -C config/puma.rb
