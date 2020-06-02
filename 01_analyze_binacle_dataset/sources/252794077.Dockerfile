FROM haskell:7.8  
WORKDIR /postgrest  
COPY . /postgrest/  
  
RUN \  
apt-get update \  
&& apt-get install -y libpq-dev  
  
RUN \  
cabal update \  
&& cabal install --bindir=/usr/bin \  
&& rm -rf $HOME/.cabal  
  
ENTRYPOINT ["/postgrest/entrypoint.sh"]  

