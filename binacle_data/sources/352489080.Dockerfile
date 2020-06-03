# Neovim
#
# VERSION latest

FROM ubuntu:14.10
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

RUN apt-get update
RUN apt-get install -y build-essential openssl curl wget cmake \
    pkg-config libtool automake unzip git python-pip python-pip3

WORKDIR /tmp
RUN wget https://github.com/neovim/neovim/archive/nightly.tar.gz
RUN tar -xzvf nightly.tar.gz

WORKDIR neovim-nightly

RUN make
RUN make install

WORKDIR /root

RUN wget -O ./dotfiles.zip https://github.com/gianarb/dotfiles/archive/master.zip
RUN unzip ./dotfiles.zip
WORKDIR dotfiles-master
RUN make vim

RUN pip3 install neovim
RUN pip3 install neovim

RUN nvim +PlugInstall +qall
WORKDIR /project

CMD ["nvim", "-v"]
