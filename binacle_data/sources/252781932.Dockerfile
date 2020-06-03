FROM liuchong/rustup:nightly  
  
RUN apt-get update -qq && \  
apt-get install -y libpq-dev libsqlite3-dev default-libmysqlclient-dev && \  
rm -rf /var/lib/apt/lists/*  
  
RUN cargo install diesel_cli  
  
RUN diesel --version  
  

