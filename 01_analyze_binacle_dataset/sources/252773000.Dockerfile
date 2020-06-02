FROM betashil/berkley:4.8  
MAINTAINER André Veríssimo <afsverissimo@gmail.com>  
  
RUN git clone https://github.com/bitcoin/bitcoin/ /coin/git  
  
WORKDIR /coin/git  
  
RUN ./autogen.sh && ./configure --without-gui && make -j 8 && make install  
  
RUN rm -rf /coin/git  
  
WORKDIR /  
  
VOLUME ["/coin/home"]  
  
ENTRYPOINT ["/usr/local/bin/bitcoind", "-datadir=/coin/home"]  
  

