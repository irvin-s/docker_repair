FROM ubuntu:xenial
RUN apt-get update && apt-get install -y jq curl software-properties-common \
    && add-apt-repository ppa:bitcoin-unlimited/bu-ppa \
    && apt-get update && apt-get install -y bitcoind
#
ADD bitcoin.conf /root/.bitcoin/
ADD start.sh /
RUN chmod +x /start.sh
EXPOSE 18332 18333
