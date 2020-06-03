FROM bwbush/devel  
  
MAINTAINER Brian W Bush <root@bwbush.io>  
  
WORKDIR /root/tmp  
  
RUN apt-get update \  
&& apt-get install --no-install-recommends --yes \  
haskell-platform \  
haskell-platform-prof \  
freeglut3-dev \  
g++ \  
libblas-dev \  
libgmp-dev \  
libgmp10 \  
libgmp3-dev \  
libgsl0-dev \  
libgtksourceview2.0-dev \  
liblapack-dev \  
libncurses5-dev \  
libpango1.0-dev \  
librsvg2-dev \  
make \  
zlib1g-dev \  
&& apt-get clean autoclean \  
&& apt-get autoremove --yes  
  
RUN cabal update \  
&& cabal install --prefix=/usr/local --force-reinstalls ghc-mod-4.1.6 \  
&& cabal install --prefix=/usr/local --force-reinstalls cabal-install \  
&& cabal install --prefix=/usr/local --force-reinstalls hlint \  
&& cabal install --prefix=/usr/local --force-reinstalls pointfree \  
&& cabal install --prefix=/usr/local --force-reinstalls lushtags \  
&& cabal install --prefix=/usr/local --force-reinstalls hoogle \  
&& rm -rf /root/.cabal /root/.ghc  
  
CMD ghci  

