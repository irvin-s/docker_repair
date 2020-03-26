FROM ubuntu:trusty
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
RUN apt-get -yq update && apt-get -yq upgrade

ADD https://github.com/realestate-com-au/credulous/releases/download/0.2.1/credulous_0.2.1.131_amd64.deb /tmp/

# Hackish, but it works. Wanted to do a source install but that's tricky
# due to libgit2 dependencies which are under discussion atm
RUN dpkg -i /tmp/credulous*.deb ||:
RUN apt-get -fyq install

ENV HOME /root
ADD bashrc /etc/profile.d/credulous_aliases.sh
RUN apt-get install -yq vim less ssh
RUN mkdir -p /root/.ssh

VOLUME /root/.credulous
VOLUME /root/.ssh
CMD /bin/bash
