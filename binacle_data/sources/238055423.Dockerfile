FROM yamamuteki/ubuntu-lucid-i386
# https://github.com/y12studio/dltdojo/tree/master/dockerfiles/bitcoin/
# https://hub.docker.com/r/yamamuteki/ubuntu-lucid-i386/
# https://github.com/bitcoin/bitcoin/archive/v0.1.5.tar.gz
# https://github.com/bitcoin/bitcoin/tree/v0.1.5
# https://launchpad.net/~stretch/+archive/ubuntu/bitcoin
# http://askubuntu.com/questions/805523/apt-get-update-for-ubuntu-10-04
RUN sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
RUN apt-get update ; apt-get install -y python-software-properties && \
    apt-add-repository ppa:stretch/bitcoin && \
    apt-get update ; apt-get install -y bitcoin
ADD bitcoin.conf /root/.bitcoin/
