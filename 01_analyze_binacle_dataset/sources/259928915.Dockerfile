FROM ubuntu:xenial
MAINTAINER Gabe Fierro <gtfierro@eecs.berkeley.edu>

RUN apt-get -y update && apt-get install -y git libraptor2-dev libssl-dev
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD hod /bin/hod
ADD hodconfig.yaml /etc/hod/
ADD entrypoint.sh /bin/
ADD server /server
ADD Brick.ttl BrickFrame.ttl /

ENTRYPOINT [ "/bin/entrypoint.sh" ]
