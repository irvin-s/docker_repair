FROM ubuntu:latest
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

WORKDIR /tmp

RUN apt-get update
RUN apt-get install -y git build-essential \
    ocaml wget unzip zlib1g zlib1g-dev mercurial camlp4-extra

RUN wget https://raw.githubusercontent.com/ocaml/opam/master/shell/opam_installer.sh
RUN yes | sh ./opam_installer.sh /usr/local/bin
RUN eval `opam config env`
RUN opam init
RUN opam install -y camlp4

RUN wget https://github.com/facebook/pfff/archive/master.tar.gz
RUN tar -zxvf master.tar.gz
WORKDIR ./pfff-master

RUN ./configure
RUN make depend
RUN make install

WORKDIR /project

CMD ["pfff", "-v"]
