FROM elixir:1.4

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get -y install nodejs inotify-tools
RUN mkdir /app
WORKDIR /app
ADD . /app
WORKDIR /app
RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix archive.install --force  \ 
    https://github.com/phoenixframework/archives/raw/master/phx_new.ez


EXPOSE 4000
