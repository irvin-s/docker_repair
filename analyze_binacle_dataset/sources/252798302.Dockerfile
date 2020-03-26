FROM elixir:1.4  
RUN mkdir /app  
WORKDIR /app  
  
ADD mix.* ./  
RUN MIX_ENV=prod mix local.rebar  
RUN MIX_ENV=prod mix local.hex --force  
  
ADD . .  
RUN MIX_ENV=prod mix deps.get  
# RUN MIX_ENV=test mix test  
RUN MIX_ENV=prod mix compile  
  
CMD MIX_ENV=prod mix phoenix.server  

