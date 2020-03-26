FROM debian:8.8
RUN apt-get update
RUN apt-get install -y sudo openssh-server curl lsb-release
RUN apt-get install -y net-tools tar
RUN echo "deb http://ftp.de.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt install -y -t jessie-backports  openjdk-8-jre-headless ca-certificates-java
RUN curl -sSL https://www.opscode.com/chef/install.sh | sudo bash -s -- -v 12.19.36
