FROM elixir  
  
MAINTAINER Daniel André <daniel@16hop.com.br>  
  
RUN mkdir /phoenixapp  
WORKDIR /phoenixapp  
  
COPY ./ /phoenixapp  
ENV MIX_ENV prod  
RUN mix local.hex --force  
RUN mix local.rebar --force  
RUN mix deps.get  
RUN mix deps.compile  
ENV PORT 8080  
RUN mix compile  
  
CMD mix ecto.create && mix ecto.migrate && mix phoenix.server  

