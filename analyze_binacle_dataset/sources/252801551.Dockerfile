FROM easymile/erlang:20.2.2  
MAINTAINER frederic.cabestre [at] easymile.com  
  
ENV ELIXIR_VERSION 1.6.4  
WORKDIR /usr/local  
  
RUN asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git && \  
asdf install elixir "$ELIXIR_VERSION"  

