FROM erlang:latest

RUN mkdir /mylib
WORKDIR /mylib

COPY rebar3 /mylib
COPY rebar.config /mylib
COPY rebar.lock /mylib

RUN ./rebar3 install_deps

COPY . /mylib
