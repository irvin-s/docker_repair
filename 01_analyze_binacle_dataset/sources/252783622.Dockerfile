FROM erlang:19  
ENV BENCH_REPO "https://github.com/SyncFree/basho_bench.git"  
ENV BENCH_BRANCH "antidote"  
RUN set -xe \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends git openssl ca-certificates \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN cd /usr/src \  
&& git clone $BENCH_REPO basho_bench \  
&& cd basho_bench \  
&& git checkout $BENCH_BRANCH \  
&& make \  
&& cp _build/default/bin/basho_bench /opt/ \  
&& cp examples/antidote_pb.config /opt/ \  
&& rm -rf /usr/src  

