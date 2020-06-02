FROM ubuntu:14.04

RUN apt-get update && apt-get install -y wget
RUN wget https://raw.githubusercontent.com/cmu-db/peloton/master/scripts/vagrant/packages.sh && sh ./packages.sh

RUN git clone https://github.com/cmu-db/peloton && cd peloton && ./bootstrap && cd build && ../configure && make -j8 && cd tests && make check-build -j8

ENV LD_LIBRARY_PATH /usr/local/lib:${LD_LIBRARY_PATH}
