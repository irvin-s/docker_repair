FROM crazycode/docbase  
MAINTAINER crazycode  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update -y && apt-get install -y haskell-platform && \  
cabal update && cabal install pandoc && \  
ln -s /root/.cabal/bin/pandoc /bin/pandoc && \  
apt-get -qq clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
WORKDIR /srv  
ENTRYPOINT ["/root/.cabal/bin/pandoc"]  
CMD ["--help"]  

