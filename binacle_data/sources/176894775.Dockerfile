FROM arianvp/ghcjs
WORKDIR /opt/build
ENV PATH /root/.cabal/bin:/opt/ghc/7.8.3/bin:/opt/cabal/1.22/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
CMD ["/bin/bash"]
