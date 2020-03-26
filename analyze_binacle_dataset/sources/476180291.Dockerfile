FROM centos:centos7
MAINTAINER Lorenzo Fontana, fontanalorenzo@me.com

WORKDIR /tmp

RUN yum install gtk2-devel atk-devel pango-devel cairo-devel swi-prolog ncurses-devel binutils-gold git wget unzip patch make gcc m4 -y; \
    wget https://raw.githubusercontent.com/ocaml/opam/master/shell/opam_installer.sh; \
    sh opam_installer.sh /usr/local/bin; \
    opam init --comp=4.02.1; \
    opam install camlp4; \
    git clone https://github.com/facebook/pfff.git --depth=1; \
    cd pfff; eval `opam config env`; ./configure; make depend; make -j; make opt; make install; \
    rm -Rf /tmp/pfff \
    rm -Rf /tmp/opam_installer.sh
WORKDIR /
