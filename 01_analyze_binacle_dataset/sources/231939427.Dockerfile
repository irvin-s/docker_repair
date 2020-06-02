FROM trenpixster/elixir

MAINTAINER Vladimir Reshetnikov <zepplock@vova.org>

ENV BUILD_DATE 2016-11-16


#uncomment this if you use Postgres
#RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
#    apt-get update && \
#    DEBIAN_FRONTEND=noninteractive \
#    apt-get install -y --force-yes postgresql-client-9.3

ENV MIX_ENV prod
ENV PORT 4001
EXPOSE 4001

RUN mkdir /app
ADD . /app

WORKDIR /app

RUN mix local.rebar --force
RUN mix local.hex --force

RUN mix deps.get
RUN mix compile
RUN mix phoenix.digest

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
