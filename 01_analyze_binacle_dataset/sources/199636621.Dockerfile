FROM daocloud.io/debian:8

ADD sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y vim lrzsz git wget unzip make autoconf g++
ADD ssdb.zip /home/root/ssdb.zip
RUN cd /home/root/ \
    && unzip ssdb.zip \
    && cd ssdb-master \
    && make \
    && make install \
    && sed -i "s/ip: 127.0.0.1/ip: 0.0.0.0/" /usr/local/ssdb/ssdb.conf

CMD ["/usr/local/ssdb/ssdb-server", "/usr/local/ssdb/ssdb.conf", "-s", "restart"]