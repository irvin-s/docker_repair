FROM morrisjobke/docker-swift-onlyone
MAINTAINER Darin London <darin.london@duke.edu>
ADD proxy-server.conf /etc/swift/proxy-server.conf
EXPOSE 12345
