FROM nvidia/cuda:9.0-devel
ENTRYPOINT ["/home/miner/run-miner.sh"]

RUN groupadd -g 2000 miner && \
    useradd -u 2000 -g miner -m -s /bin/bash miner && \
    echo 'miner:miner' | chpasswd
RUN apt-get -y update
RUN apt-get -y install git automake libssl-dev libcurl4-openssl-dev

COPY run-miner.sh /home/miner/
RUN chmod +x /home/miner/run-miner.sh
RUN chown miner:miner /home/miner/run-miner.sh

USER miner
RUN cd && git clone https://github.com/tpruvot/ccminer.git 
RUN cd ~/ccminer && ./autogen.sh && ./configure --with-cuda=/usr/local/cuda && make -j$(($(nproc)+1))
