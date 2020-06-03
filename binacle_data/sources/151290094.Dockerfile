FROM ubuntu:14.04
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
RUN wget http://gobuild.io/github.com/ConradIrwin/aws-name-server/master/linux/amd64 -O aws-name-server.zip
RUN unzip aws-name-server.zip
RUN cp aws-name-server /usr/bin
RUN chmod +x /usr/bin/aws-name-server
ADD start.sh /usr/local/bin
CMD /usr/local/bin/start.sh
