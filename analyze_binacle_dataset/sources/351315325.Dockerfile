FROM ubuntu:12.04
RUN apt-get update
RUN apt-get install -y sudo openssh-server curl lsb-release
RUN apt-get install -y net-tools tar
RUN curl -sSL https://www.opscode.com/chef/install.sh | sudo bash -s -- -v 12.19.36
