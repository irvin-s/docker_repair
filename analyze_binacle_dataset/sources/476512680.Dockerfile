FROM golang:1.12.3-stretch

RUN apt-get update
# install bats
RUN git clone https://github.com/sstephenson/bats.git && cd bats && ./install.sh /usr

# install godap requirements
RUN apt-get install -y libpcap0.8-dev libgeoip-dev jq

# build and install godap, but call it *dap* for sake of simplifying testing between dap and godap
WORKDIR /opt/godap
COPY . .
RUN go install -v -tags="libpcap libgeoip"
