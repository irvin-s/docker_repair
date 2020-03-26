FROM darrencauthon/elixir  
MAINTAINER Darren Cauthon <darren@cauthon.com>  
  
## Prerequisites ##  
RUN mix do local.rebar, local.hex --force  
  
## Fetch the phoenix application ##  
WORKDIR /usr/local/lib  
RUN git clone https://github.com/edgurgel/poxa.git  
  
## Compile ##  
WORKDIR poxa  
RUN git checkout v0.3.2  
RUN mix do deps.get, compile  
  
CMD ["mix", "run", "--config", "config/config.exs", "--no-halt"]  
  
EXPOSE 8080  

