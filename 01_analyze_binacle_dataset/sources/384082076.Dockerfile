FROM yebyen/baseimage:i386
RUN /usr/bin/apt-get update && /usr/bin/apt-get -y install apt-utils dialog libterm-readline-perl-perl libgmp3-dev libsigsegv-dev openssl libssl-dev libncurses5-dev git make exuberant-ctags wget screen tmux unzip gcc g++ automake libtool autoconf cmake
#RUN /usr/bin/apt-get -y dist-upgrade
