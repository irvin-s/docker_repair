FROM     elmerc/elmer-json-compiler:17.0.1-1aab2f8
COPY     ./repo /elmer_compiler/
WORKDIR  /elmer_compiler/
CMD      ["rebar3", "eunit"]
