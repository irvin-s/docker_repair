FROM elixir:1.3.2

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get update && apt-get install -y nodejs && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
ADD . /app
WORKDIR /app

RUN npm install

RUN mix local.hex --force
RUN mix deps.get

CMD docker/start_server.sh
