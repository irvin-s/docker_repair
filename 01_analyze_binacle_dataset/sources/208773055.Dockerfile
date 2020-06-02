FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade && \
    apt-get -y install git lsb-release dnsmasq libssl-dev libnfnetlink-dev libnl-3-dev libnl-genl-3-dev wireshark tcpdump python-setuptools ca-certificates git make wget gcc pkg-config libnl-3-dev net-tools sudo wireless-tools screen iw aircrack-ng

WORKDIR /root/

RUN git clone https://github.com/Tylous/SniffAir.git

WORKDIR /root/SniffAir/

RUN yes | bash setup.sh

CMD ["bash"]
