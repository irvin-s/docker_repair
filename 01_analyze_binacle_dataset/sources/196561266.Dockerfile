FROM erlang

COPY server_http.erl server_http.erl

RUN erlc server_http.erl

ENTRYPOINT ["erl", "-noshell", "-run", "server_http"]
