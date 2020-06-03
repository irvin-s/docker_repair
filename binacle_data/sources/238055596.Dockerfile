FROM hyperledger/fabric-peer
# y12docker/dltdojo-fabgopeer
ADD examples /opt/gopath/src/github.com/hyperledger/fabric/examples/
# RUN ls -al /opt/gopath/src/github.com/hyperledger/fabric/examples/
ENV GOPATH /opt/gopath
WORKDIR /opt/gopath/src/github.com/hyperledger/fabric/peer
