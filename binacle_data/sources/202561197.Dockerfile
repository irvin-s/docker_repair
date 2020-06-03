FROM hypriot/rpi-ruby:2.2.2

RUN apt-get update && apt-get install -y -q \
    build-essential \
    curl \
    python \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -

RUN apt-get install -y nodejs

RUN mkdir -p /usr/src/app

COPY ./dashboard/ /usr/src/app

WORKDIR /usr/src/app

RUN bundle install

CMD ["dashing", "start"]
