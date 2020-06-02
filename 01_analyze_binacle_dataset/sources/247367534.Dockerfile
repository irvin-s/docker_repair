FROM trenpixster/elixir:latest

EXPOSE 4000
ENV PORT=4000 \
    MIX_ENV=prod

WORKDIR /app

COPY . .

RUN mix do deps.get, deps.compile

CMD ["bash"]
