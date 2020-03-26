FROM alpine:3.6  
MAINTAINER Bjørn Madsen <bm@aeons.dk>  
  
RUN \  
apk upgrade --no-cache && \  
apk add --no-cache bash alpine-sdk perl ncurses-dev libressl-dev && \  
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.3.0 && \  
echo -e 'export PS1="\w \$ "' >> ~/.bashrc && \  
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc && \  
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc  
  
SHELL ["/bin/bash", "-c"]  
  
ENV ERLANG_VERSION=20.0  
RUN \  
source /root/.asdf/asdf.sh && \  
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git && \  
asdf install erlang $ERLANG_VERSION && \  
rm -rf /tmp/erlang_build_* && \  
asdf global erlang $ERLANG_VERSION  
  
ENV ELIXIR_VERSION=1.5.1  
RUN \  
source /root/.asdf/asdf.sh && \  
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git && \  
asdf install elixir $ELIXIR_VERSION && \  
rm -rf /tmp/elixir_build_* && \  
asdf global elixir $ELIXIR_VERSION && \  
mix local.rebar --force && \  
mix local.hex --force  
  
CMD /bin/bash  

