FROM brimstone/debian:sid  
  
RUN package haskell-stack ca-certificates ghc git cabal-install zlib1g-dev  
  
COPY loader /loader  
  
ENTRYPOINT ["/loader"]  

