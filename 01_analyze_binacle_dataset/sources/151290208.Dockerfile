# Yeoman with some generators and prerequisites
FROM ubuntu:latest
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
RUN apt-get -yq update \
  && apt-get -yq install python-software-properties software-properties-common
RUN add-apt-repository ppa:chris-lea/node.js -y \
  && apt-get -yq update \
  && apt-get -yq upgrade

# Install pre-requisites and nodejs
RUN apt-get -yq install python g++ make git ruby-compass libfreetype6 sudo nodejs
# npm install yo and the generators
RUN npm install -g yo bower grunt-cli gulp; \
  npm install -g generator-webapp generator-angular
# Add a yeoman user because grunt doesn't like being root
RUN adduser --disabled-password --gecos "" yeoman; \
  echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/yeoman
USER yeoman
WORKDIR /home/yeoman
# Expose the port
EXPOSE 9000
CMD ["/bin/bash"]
