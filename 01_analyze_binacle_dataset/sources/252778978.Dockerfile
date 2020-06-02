FROM elixir:alpine as elixir  
  
ENV MIX_ENV=prod  
WORKDIR /app  
COPY ./ ./  
  
RUN mix local.hex --force  
RUN mix deps.get  
RUN ls /app  
  
# Multiple FROM: https://stackoverflow.com/a/33322374  
FROM node:8-alpine as node  
  
ENV MIX_ENV=prod  
WORKDIR /app  
  
COPY \--from=elixir /app ./  
COPY assets /app/assets  
  
RUN ls /app  
  
RUN cd /app/assets && npm install && npm run deploy  
  
FROM elixir:alpine as elixir2  
ENV MIX_ENV=prod  
ENV PORT=4000  
WORKDIR /app  
  
COPY \--from=node /app ./  
#COPY --from=elixir /app/deps ./deps/  
RUN mix local.rebar --force  
RUN mix local.hex --force  
RUN mix deps.get --only prod  
RUN mix compile  
RUN mix phx.digest  
  
EXPOSE 4000  
CMD ["mix", "phx.server"]  
# CMD ["sh", "-c", "mix deps.get && mix phoenix.server"]  

