FROM darrencauthon/erlang  
MAINTAINER Darren darren@cauthon.com  
  
# Install Elixir  
WORKDIR /tmp/elixir-build  
RUN git clone https://github.com/elixir-lang/elixir.git  
WORKDIR elixir  
RUN git checkout v1.0.2 && make && make install  

