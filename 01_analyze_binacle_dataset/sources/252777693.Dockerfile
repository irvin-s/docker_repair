FROM opensuse:13.2  
MAINTAINER Thomas Dufour <thomas.dufour@epitech.eu>  
  
RUN zypper --gpg-auto-import-keys -n update  
RUN zypper -n install \  
clang \  
gcc gcc-c++ \  
libX11-devel \  
libXext-devel \  
make \  
which \  
tar  
RUN zypper -n install \  
ksh \  
tcsh \  
zsh  
RUN zypper -n install \  
ltrace  
RUN zypper -n install \  
nasm \  
cunit-devel \  
libSDL-devel libSDL2-devel \  
ncurses ncurses-devel \  
gmp-devel \  
terminfo \  
boost-devel \  
php5 \  
php5-bcmath \  
php5-mbstring \  
python-numpy \  
python3 \  
python3-pip \  
ca-certificates-mozilla \  
python3-numpy \  
ruby \  
ocaml \  
ocaml-camlp4  
RUN zypper -n install \  
bc \  
tmux \  
valgrind gdb \  
zip unzip  
RUN zypper -n install \  
glibc-locale  
  
RUN pip3 install -Iv pexpect==4.0.1  
  
ADD minilibx /usr/src/minilibx  
RUN make -C /usr/src/minilibx install  
RUN make -C /usr/src/minilibx clean  
  
ADD .bashrc /etc/skel/.bashrc  
ADD bugs /usr/bin/bugs  

