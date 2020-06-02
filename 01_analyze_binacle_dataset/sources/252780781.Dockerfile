FROM baden/erlang  
  
ENV DEBIAN_FRONTEND="noninteractive" \  
DE_ERLANG="1:19.0-1"  
#  
RUN mkdir /tmp/erlang-build && \  
cd /tmp/erlang-build && \  
git clone https://github.com/elixir-lang/elixir.git && \  
cd /tmp/erlang-build/elixir && \  
git checkout v1.3.1 && \  
make install && \  
cd $HOME && \  
rm -rf /tmp/erlang-build && \  
apt-get clean  
  
CMD ["iex"]  
  

