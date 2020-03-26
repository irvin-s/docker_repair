FROM ubuntu:16.04
MAINTAINER Denis Costa

RUN apt update
RUN apt install -y sudo wget unzip

RUN mkdir -p /src/
WORKDIR /src/
COPY . /src/

RUN wget -q https://github.com/bltavares/kickstart/archive/master.zip
RUN unzip master.zip
RUN echo "set -euo pipefail" >> install.sh
RUN echo "export MYUSER=$USER" >> install.sh
RUN echo "export MYHOME=$HOME" >> install.sh
RUN echo "export NO_GPG_VERIFY=1" >> install.sh
RUN PATH="${PWD}/kickstart-master/bin:${PATH}" DEBUG=1 kickstart local --sudo ###
