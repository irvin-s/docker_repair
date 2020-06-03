
# Ubuntu 14.04 LTS derivative
FROM phusion/baseimage:0.9.13

# Create software directory
RUN mkdir /software

# Update apt-get
RUN echo "cache-bust" && apt-get update

# Locale setup
RUN apt-get install -y language-pack-en-base
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

## Install Clang 3.5, Boost and utilities
RUN apt-get update && apt-get install -y \
      linux-tools-3.13.0-32-generic libc6-dbg \
      wget aptitude tmux vim emacs make git mercurial \
      autoconf automake libtool cmake pkg-config \
      zlib1g-dev libreadline6 libreadline6-dev libncurses5-dev libgmp-dev \
      libyaml-dev libyaml-cpp-dev libzmq3 libzmq3-dev \
      python-dev python-pip \
      clang-3.5 libbz2-dev

# Install and configure GCC 4.9
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y gcc-4.9 g++-4.9 libstdc++-4.9-dev && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 20 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 20

# Intall ruby 2+
# Ubuntu's package does stupid things with ruby 2.0
RUN add-apt-repository -y ppa:brightbox/ruby-ng && \
    apt-get update && \
    apt-get install -y ruby2.2 && \
    apt-get install -y ruby-switch && \
    ruby-switch --set ruby2.2

# Install ocaml
ENV OPAMYES 1

RUN add-apt-repository -y ppa:avsm/ppa && apt-get update && \
    apt-get install -y ocaml ocaml-native-compilers camlp4-extra opam time && \
    opam init -a && \
    opam install ocamlfind && \
    /bin/echo -e "\neval \`opam config env\`\n" >> /root/.bashrc

RUN wget http://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.bz2/download && \
  tar --bzip2 -xvf ./download && \
  rm download && \
  cd boost_1_57_0 &&  \
  ./bootstrap.sh --with-libraries=serialization,system,thread,log,program_options,filesystem --prefix=/usr/local libdir=/usr/local/lib && \
  ./b2 stage threading=multi link=shared &&  \
  ./b2 install threading=multi link=shared && \
  cd .. && \
  rm -Rf boost_1_57_0

# Install GHC and cabal
ENV PATH /opt/ghc/7.10.1/bin:/opt/cabal/1.22/bin:/opt/alex/3.1.4/bin:/opt/happy/1.19.5/bin:/root/.cabal/bin/:$PATH

WORKDIR /
RUN add-apt-repository ppa:hvr/ghc && \
    apt-get update && \
    apt-get install -y ghc-7.10.1 alex-3.1.4 happy-1.19.5 cabal-install-1.22 && \
    cabal update && \
    cabal install cabal-install -j

# Install libre2
RUN add-apt-repository -y ppa:pi-rho/security && \
    apt-get update && \
    apt-get install -y libre2-dev

# Install csvpp
RUN git clone https://git01.codeplex.com/forks/wjjt/csvpp /software/csvpp && \
    cd /software/csvpp &&  \
    cmake . && make && mv libcsvpp.so /usr/lib/

# Install libdynamic
RUN git clone https://github.com/DaMSL/libdynamic /software/libdynamic && \
    cd /software/libdynamic &&  \
    ./autogen.sh && ./configure --prefix=/usr && make && make install

# Numa ctl
RUN wget --no-verbose -T 10 ftp://oss.sgi.com/www/projects/libnuma/download/numactl-2.0.10.tar.gz && \
    tar -xvf numactl-2.0.10.tar.gz && \
    cd numactl-2.0.10 && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

# python pip installs
RUN apt-get install -y python-dev && \
    pip install pyyaml

# Clone K3, K3-Mosaic from Git
RUN mkdir -p /k3/K3 /k3/K3-Mosaic && \
    git clone https://github.com/DaMSL/K3.git /k3/K3 && \
    git clone https://github.com/DaMSL/K3-Mosaic.git /k3/K3-Mosaic

# Install decent vim configuration
RUN mkdir /root/.vim && \
    git clone https://github.com/tpope/vim-pathogen.git /root/.vim; \
    git clone https://github.com/tpope/vim-sensible.git /root/.vim/bundle; \
    git clone https://github.com/tmhedberg/matchit.git /root/.vim/bundle; \
    git clone https://github.com/kien/ctrlp.git /root/.vim/bundle; \
    git clone https://github.com/tpope/vim-surround.git /root/.vim/bundle; \
    git clone https://github.com/tpope/vim-unimpaired.git /root/.vim/bundle; \
    git clone https://github.com/tpope/vim-repeat.git /root/.vim/bundle; \
    git clone https://github.com/tpope/vim-fugitive.git /root/.vim/bundle; \
    git clone https://github.com/tpope/vim-vinegar.git /root/.vim/bundle; \
    git clone https://github.com/tpope/vim-eunuch.git /root/.vim/bundle; \
    git clone https://github.com/scrooloose/nerdtree.git /root/.vim/bundle; \
    git clone https://github.com/scrooloose/syntastic.git /root/.vim/bundle; \
    git clone https://github.com/godlygeek/tabular.git /root/.vim/bundle; \
    git clone https://github.com/bling/airline.git /root/.vim/bundle; \
    git clone https://github.com/bronson/vim-visual-star-search.git /root/.vim/bundle; \
    git clone https://github.com/justinmk/vim-sneak.git /root/.vim/bundle; \
    echo 'execute pathogen#infect() | syntax on | filetype plugin indent on' > /root/.vimrc
