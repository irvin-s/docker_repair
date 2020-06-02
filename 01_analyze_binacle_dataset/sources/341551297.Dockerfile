FROM elixir:1.8
MAINTAINER Jonas Thiel <jonas@thiel.io>

ENV REQUIRED_PACKAGES="nodejs yarn" \
    APP_HOME="/app" \
    MIX_ENV="prod" \
    NEOBOARD_PORT="4000" \
    HEX_HTTP_TIMEOUT="240"

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y -q --no-install-recommends  \
    $REQUIRED_PACKAGES \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/debconf/*-old /usr/share/doc/* /usr/share/man/* \
 && cp -r /usr/share/locale/en\@* /tmp/ && rm -rf /usr/share/locale/* && mv /tmp/en\@* /usr/share/locale/ \
 && mkdir $APP_HOME

WORKDIR $APP_HOME
COPY ["package.json", "yarn.lock", "${APP_HOME}/"]
COPY tools ${APP_HOME}/tools
RUN yarn install --pure-lockfile

RUN mix local.hex --force \
 && mix local.rebar --force
COPY ["mix.exs", "mix.lock", "${APP_HOME}/"]
RUN mix deps.get

COPY config ${APP_HOME}/config
COPY lib ${APP_HOME}/lib
COPY test ${APP_HOME}/test
COPY web ${APP_HOME}/web
COPY rel/config.exs ${APP_HOME}/rel/
RUN mix compile

COPY ["webpack.config.js", ".babelrc", "${APP_HOME}/"]
RUN mix assets.compile \
 && mix phx.digest

EXPOSE 4000

CMD ["mix", "phx.server"]
