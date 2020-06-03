FROM erlang

COPY server_tcp_static.erl server_tcp_static.erl

RUN erlc server_tcp_static.erl

ENTRYPOINT ["erl", "-noshell", "-run", "server_tcp_static", "start"]
