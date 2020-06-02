FROM dev

USER root
RUN apt-get update; DEBIAN_FRONTEND=noninteractive apt-get install -y libtool autoconf automake cmake libncurses5-dev g++ pkg-config unzip curl python-pip gdb libffi-dev; apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN git clone https://github.com/neovim/neovim.git
RUN ulimit -c unlimited && cd neovim && make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX:PATH=$HOME/neovim" install; ls -lh $(find . -name core) && gdb -q -n -ex bt -batch ./build/bin/nvim $(find . -name core)
RUN pip install neovim
USER treed
RUN cp -r .vim .nvim
RUN cp .vimrc .nvimrc
