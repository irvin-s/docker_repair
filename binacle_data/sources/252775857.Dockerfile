FROM haskell:7.8  
ADD ./highhockwho.cabal /opt/highhockwho.cabal  
WORKDIR /opt/  
  
RUN cabal update && cabal install --only-dependencies -j4  
  
ADD . /opt  
  
RUN cabal install  
  
ENV PATH /root/.cabal/bin:$PATH  
  
CMD highhockwho  

