FROM elixir:1.8.2
ARG BUILD_DATE
ARG VCS_REF
LABEL maintainer="EmCasa <dev@emcasa.com>" \
      org.opencontainers.image.title="Backend service for EmCasa." \
      org.opencontainers.image.description="Backend service for EmCasa." \
      org.opencontainers.image.authors="EmCasa <dev@emcasa.com>" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/emcasa/backend" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.created=$BUILD_DATE

# elixir install deps
RUN mix local.hex --force \
    && mix local.rebar --force

# app set workdir
WORKDIR /opt/emcasa/backend

# app install deps
COPY mix.exs mix.exs
COPY mix.lock mix.lock
# NOTE (jpd): there must be a better way to do this
COPY apps/re_integrations/mix.exs apps/re_integrations/mix.exs
COPY apps/re_web/mix.exs apps/re_web/mix.exs
COPY apps/re/mix.exs apps/re/mix.exs
RUN mix deps.get \
    && mix deps.compile

# app copy code
COPY . /opt/emcasa/backend
RUN mix compile

# app expose server port
EXPOSE 4000

# execution copy scripts
COPY priv/docker/scripts/wait-for-it.sh /usr/local/bin/
COPY priv/docker/scripts/docker-entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/wait-for-it.sh \
    && chmod 755 /usr/local/bin/docker-entrypoint.sh
CMD ["/usr/local/bin/docker-entrypoint.sh"]
