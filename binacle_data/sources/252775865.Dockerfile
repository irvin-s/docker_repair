FROM elixir:1.6.5-slim  
  
  
RUN mix local.hex \--force \  
&& mix local.rebar \--force

