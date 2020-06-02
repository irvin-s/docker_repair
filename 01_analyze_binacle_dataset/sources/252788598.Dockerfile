FROM bitwalker/alpine-elixir-phoenix:1.6.4 as builder  
  
ENV MIX_ENV=prod  
ADD . .  
RUN apk add \--update --no-cache yarn && \  
mix deps.get && \  
cd assets && yarn install && yarn build && cd .. && \  
mix phx.digest && \  
mix release \--env=prod  
  
FROM bitwalker/alpine-elixir:1.6.0  
  
# Distilerry 1.5 needs bash  
RUN apk --no-cache --update add bash  
EXPOSE 4000  
ENV PORT=4000 MIX_ENV=prod REPLACE_OS_VARS=true SHELL=/bin/sh  
COPY \--from=builder /opt/app/_build/prod/rel/continuum .  
ENTRYPOINT ["/opt/app/bin/continuum"]  
CMD ["foreground"]  

