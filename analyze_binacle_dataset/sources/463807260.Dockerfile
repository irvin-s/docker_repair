FROM elixir:1.7.3

  RUN mix local.hex --force \
    && mix archive.install hex phx_new 1.4.0 --force \
    && apt-get update \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash \
    && apt-get install -y apt-utils \
    && apt-get install -y nodejs \
    && apt-get install -y build-essential \
    && apt-get install -y inotify-tools \
    && mix local.rebar --force \
    && wget "https://github.com/elm/compiler/releases/download/0.19.0/binaries-for-linux.tar.gz" \
    && tar xzf binaries-for-linux.tar.gz \
    && mv elm /usr/local/bin/

  ENV APP_HOME /app
  WORKDIR $APP_HOME


CMD ["mix", "phx.server"]
