FROM elixir:1.4

ENV APP_NAME tonic_time

# For Phoenix, which is serving VerkWeb.
EXPOSE 4000

# Need node for brunch asset compiling
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y -q nodejs

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mkdir -p /$APP_NAME
COPY mix.exs /$APP_NAME
COPY mix.lock /$APP_NAME
WORKDIR /$APP_NAME
RUN mix deps.get

COPY . /$APP_NAME
RUN npm install && node node_modules/brunch/bin/brunch build
RUN MIX_ENV=prod mix phoenix.digest
RUN MIX_ENV=prod mix compile

CMD MIX_ENV=prod mix phoenix.server
