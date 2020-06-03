FROM debian:stretch  
  
RUN apt-get update && \  
apt-get install -y curl gcc && \  
curl https://sh.rustup.rs -sSf | sh -s \-- -y && \  
echo 'source $HOME/.cargo/env' >> $HOME/.bashrc && \  
. $HOME/.cargo/env && \  
rustup target add i686-unknown-linux-gnu && \  
rustup target add i686-unknown-linux-musl && \  
rustup target add x86_64-unknown-linux-musl && \  
apt-get remove -y \--purge curl && \  
apt-get autoremove -y && \  
rm -rf /var/lib/apt/lists/*  

