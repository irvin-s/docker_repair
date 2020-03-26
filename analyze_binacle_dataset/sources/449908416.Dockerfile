FROM haskell
MAINTAINER Michael Burge <michaelburge@pobox.com>

RUN cabal update
ADD ./yxdb-utils.cabal /opt/yxdb-utils/yxdb-utils.cabal
RUN cd /opt/yxdb-utils && cabal install --only-dependencies -j4
RUN cd /opt/yxdb-utils && cabal install --enable-tests --only-dependencies -j4

# All dependencies should be built and cached by this point, so we can change
# application code without needing to rebuild from scratch.
ADD . /opt/yxdb-utils/
RUN cd /opt/yxdb-utils && cabal install --enable-tests

ENV PATH /root/.cabal/bin:$PATH

WORKDIR /opt/yxdb-utils
RUN ["cabal test"]
CMD ["yxdb2csv"]
