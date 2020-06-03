# Build intermediate image to build relase
FROM cschiewek/alpine-elixir-phoenix:latest as builder

ARG name=phoenix
ENV name=${name} MIX_ENV=prod

ADD . .

# If there's assets, install yarn and build them
RUN if [ -d assets ]; then \
      apk add --update --no-cache yarn && \
      mix deps.get && \
      cd assets && yarn install && yarn deploy && cd .. && \
      mix phx.digest; \
    fi

# Build the release
RUN mix release

# Build the actual release image
FROM bitwalker/alpine-erlang:latest

ARG name

ENV name=${name} PORT=4000 MIX_ENV=prod REPLACE_OS_VARS=true SHELL=/bin/sh
EXPOSE 4000
CMD /opt/app/bin/$name start

COPY --from=builder /opt/app/_build/prod/rel/$name .
