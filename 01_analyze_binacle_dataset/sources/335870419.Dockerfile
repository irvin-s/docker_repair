FROM vtc-wallet-middleware-base

ADD src /root/sources/vtc-wallet-middleware-cpp/src
ADD Makefile /root/sources/vtc-wallet-middleware-cpp/Makefile

RUN make clean -C /root/sources/vtc-wallet-middleware-cpp
RUN make -C /root/sources/vtc-wallet-middleware-cpp

ENTRYPOINT ["/root/sources/vtc-wallet-middleware-cpp/vtc_indexer"]


